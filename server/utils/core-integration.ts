import { createHash, createHmac, timingSafeEqual } from 'node:crypto'
import { Buffer } from 'node:buffer'
import type { H3Event } from 'h3'
import { type SupabaseClient, createClient } from '@supabase/supabase-js'
import { requireCompanyRole } from './security'
// eslint-disable-next-line import/extensions
import { serverSupabaseServiceRole } from '#supabase/server'

export const PORTAL_MEMUDE_COMPANY_ID = '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6'
const PAGE_SIZE = 500
const WEBHOOK_TOLERANCE_SECONDS = 300

type Resource = 'corretores' | 'empreendimentos' | 'leads' | 'vendas'
type SyncCounts = Record<Resource, number>
type CoreSource = SupabaseClient | { apiUrl: string; apiSecret: string }

interface CoreCorretor {
  id: string
  profile_id: string
  creci: string
  cpf: string | null
  status: string | null
  whatsapp: string
  email: string | null
  telefone: string | null
  observacoes: string | null
  deleted_at: string | null
  updated_at: string | null
  profiles?: { first_name?: string | null; last_name?: string | null } | null
}

interface CoreDevelopment {
  id: string
  nome: string
  endereco: string | null
  descricao: string | null
  ativo: boolean | null
  tipo_imovel: string | null
  updated_at: string | null
}

interface CoreLead {
  id: string
  nome: string
  telefone: string
  email: string | null
  empreendimento_id: string | null
  corretor_designado_id: string | null
  observacoes: string | null
  origem: string | null
  status: string | null
  deleted_at: string | null
  updated_at: string | null
}

interface CoreSale {
  id: string
  lead_id: string
  empreendimento_id: string
  corretor_id: string | null
  valor_imovel: number
  comissao_percentual: number
  valor_comissao_bruta: number | null
  valor_corretor: number | null
  valor_memude: number | null
  status: string
  data_venda: string
  data_pagamento: string | null
  observacoes: string | null
  updated_at: string | null
}

function coreClient(event: H3Event) {
  const config = useRuntimeConfig(event)
  if (config.coreApiUrl && config.coreApiSecret)
    return { apiUrl: config.coreApiUrl, apiSecret: config.coreApiSecret }

  if (!config.coreSupabaseUrl || !config.coreSupabaseServiceRoleKey)
    throw createError({ statusCode: 503, message: 'Integração com o MeMude Core ainda não configurada.' })

  return createClient(config.coreSupabaseUrl, config.coreSupabaseServiceRoleKey, {
    auth: { autoRefreshToken: false, persistSession: false },
  })
}

function isApiSource(source: CoreSource): source is { apiUrl: string; apiSecret: string } {
  return 'apiUrl' in source
}

async function fetchAll<T>(source: CoreSource, table: Resource, select: string): Promise<T[]> {
  const rows: T[] = []
  for (let from = 0; ; from += PAGE_SIZE) {
    let page: T[]
    if (isApiSource(source)) {
      const response = await fetch(source.apiUrl, {
        method: 'POST',
        headers: {
          'content-type': 'application/json',
          'x-finance-export-secret': source.apiSecret,
        },
        body: JSON.stringify({ resource: table, offset: from }),
      })

      const payload = await response.json() as { data?: T[]; error?: string }
      if (!response.ok)
        throw new Error(`Falha ao consultar ${table} no Core: ${payload.error ?? response.statusText}`)
      page = payload.data ?? []
    }
    else {
      const { data, error } = await source.from(table).select(select).range(from, from + PAGE_SIZE - 1)
      if (error)
        throw new Error(`Falha ao consultar ${table} no Core: ${error.message}`)
      page = (data ?? []) as T[]
    }

    rows.push(...page)
    if (page.length < PAGE_SIZE)
      return rows
  }
}

function saleStatus(status: string) {
  if (['cancelada', 'cancelado', 'canceled', 'cancelled'].includes(status))
    return 'cancelled'
  if (['pendente', 'pending'].includes(status))
    return 'pending'

  return 'completed'
}

function sourceHash(value: unknown) {
  return createHash('sha256').update(JSON.stringify(value)).digest('hex')
}

async function markSync(finance: SupabaseClient, resource: Resource, patch: Record<string, unknown>) {
  const { error } = await finance
    .from('integration_sync_state')
    .update({ ...patch, updated_at: new Date().toISOString() })
    .eq('company_id', PORTAL_MEMUDE_COMPANY_ID)
    .eq('source', 'memude_core')
    .eq('resource', resource)

  if (error)
    throw new Error(`Falha ao registrar sincronização de ${resource}: ${error.message}`)
}

async function syncEmployees(core: CoreSource, finance: SupabaseClient) {
  const rows = await fetchAll<CoreCorretor>(
    core,
    'corretores',
    'id,profile_id,creci,cpf,status,whatsapp,email,telefone,observacoes,deleted_at,updated_at,profiles(first_name,last_name)',
  )

  const payload = rows.map(row => ({
    company_id: PORTAL_MEMUDE_COMPANY_ID,
    core_corretor_id: row.id,
    full_name: `${row.profiles?.first_name ?? ''} ${row.profiles?.last_name ?? ''}`.trim() || `Corretor ${row.creci}`,
    email: row.email,
    phone: row.telefone || row.whatsapp,
    document: row.cpf,
    employment_type: 'commission_only',
    status: row.deleted_at || !['ativo', 'active'].includes(String(row.status).toLowerCase()) ? 'inactive' : 'active',
    role_title: `Corretor CRECI ${row.creci}`,
    source: 'memude_core',
    source_updated_at: row.updated_at,
  }))

  if (payload.length) {
    const { error } = await finance.from('employees').upsert(payload, { onConflict: 'company_id,core_corretor_id' })
    if (error)
      throw new Error(`Falha ao sincronizar corretores: ${error.message}`)
  }

  return rows.length
}

async function syncDevelopments(core: CoreSource, finance: SupabaseClient) {
  const rows = await fetchAll<CoreDevelopment>(
    core,
    'empreendimentos',
    'id,nome,endereco,descricao,ativo,tipo_imovel,updated_at',
  )

  const payload = rows.map(row => ({
    company_id: PORTAL_MEMUDE_COMPANY_ID,
    core_empreendimento_id: row.id,
    name: row.nome,
    address: row.endereco,
    type: 'launch',
    is_active: row.ativo !== false,
    notes: [row.tipo_imovel, row.descricao].filter(Boolean).join(' — ') || null,
    source: 'memude_core',
    source_updated_at: row.updated_at,
  }))

  if (payload.length) {
    const { error } = await finance.from('developments').upsert(payload, { onConflict: 'company_id,core_empreendimento_id' })
    if (error)
      throw new Error(`Falha ao sincronizar empreendimentos: ${error.message}`)
  }

  return rows.length
}

async function syncClients(core: CoreSource, finance: SupabaseClient) {
  const rows = await fetchAll<CoreLead>(
    core,
    'leads',
    'id,nome,telefone,email,empreendimento_id,corretor_designado_id,observacoes,origem,status,deleted_at,updated_at',
  )

  const payload = rows.map(row => ({
    company_id: PORTAL_MEMUDE_COMPANY_ID,
    core_lead_id: row.id,
    name: row.nome,
    email: row.email,
    phone: row.telefone,
    notes: [row.origem && `Origem: ${row.origem}`, row.status && `Status Core: ${row.status}`, row.observacoes].filter(Boolean).join(' — ') || null,
    is_active: !row.deleted_at,
    source: 'memude_core',
    source_updated_at: row.updated_at,
  }))

  if (payload.length) {
    const { error } = await finance.from('clients').upsert(payload, { onConflict: 'company_id,core_lead_id' })
    if (error)
      throw new Error(`Falha ao sincronizar leads: ${error.message}`)
  }

  return rows.length
}

async function idMap(finance: SupabaseClient, table: 'employees' | 'developments', externalColumn: string) {
  const { data, error } = await finance.from(table).select(`id,${externalColumn}`).eq('company_id', PORTAL_MEMUDE_COMPANY_ID)
  if (error)
    throw new Error(`Falha ao resolver referências de ${table}: ${error.message}`)
  const rows = (data ?? []) as unknown as Array<Record<string, unknown>>

  return new Map(rows.map(row => [String(row[externalColumn]), String(row.id)]))
}

async function syncSales(core: CoreSource, finance: SupabaseClient) {
  const rows = await fetchAll<CoreSale>(
    core,
    'vendas',
    'id,lead_id,empreendimento_id,corretor_id,valor_imovel,comissao_percentual,valor_comissao_bruta,valor_corretor,valor_memude,status,data_venda,data_pagamento,observacoes,updated_at',
  )

  const developments = await idMap(finance, 'developments', 'core_empreendimento_id')
  const employees = await idMap(finance, 'employees', 'core_corretor_id')

  const payload = rows.map(row => ({
    company_id: PORTAL_MEMUDE_COMPANY_ID,
    core_venda_id: row.id,
    core_lead_id: row.lead_id,
    development_id: developments.get(row.empreendimento_id) ?? null,
    broker_id: row.corretor_id ? employees.get(row.corretor_id) ?? null : null,
    sale_value: row.valor_imovel,
    sale_date: row.data_venda,
    status: saleStatus(String(row.status).toLowerCase()),
    notes: row.observacoes,
    source: 'memude_core',
    source_updated_at: row.updated_at,
    sync_hash: sourceHash(row),
  }))

  if (payload.length) {
    const { error } = await finance.from('sales').upsert(payload, { onConflict: 'company_id,core_venda_id' })
    if (error)
      throw new Error(`Falha ao sincronizar vendas: ${error.message}`)
  }

  const { data: localSales, error: salesError } = await finance
    .from('sales')
    .select('id,core_venda_id')
    .eq('company_id', PORTAL_MEMUDE_COMPANY_ID)
    .not('core_venda_id', 'is', null)

  if (salesError)
    throw new Error(`Falha ao resolver vendas sincronizadas: ${salesError.message}`)
  const sales = new Map((localSales ?? []).map(row => [String(row.core_venda_id), row.id as string]))

  const commissions = rows.map(row => ({
    company_id: PORTAL_MEMUDE_COMPANY_ID,
    core_venda_id: row.id,
    sale_id: sales.get(row.id) ?? null,
    total_amount: row.valor_comissao_bruta ?? (Number(row.valor_imovel) * Number(row.comissao_percentual) / 100),
    receipt_type: 'launch_passthrough',
    status: row.data_pagamento ? 'received' : 'pending',
    notes: 'Comissão sincronizada automaticamente do MeMude Core.',
    source: 'memude_core',
    source_updated_at: row.updated_at,
  }))

  if (commissions.length) {
    const { error } = await finance.from('commissions').upsert(commissions, { onConflict: 'company_id,core_venda_id' })
    if (error)
      throw new Error(`Falha ao sincronizar comissões: ${error.message}`)
  }

  return rows.length
}

export async function syncCore(event: H3Event) {
  const core = coreClient(event)
  const finance = serverSupabaseServiceRole(event) as unknown as SupabaseClient
  const started = new Date().toISOString()
  const resources: Resource[] = ['corretores', 'empreendimentos', 'leads', 'vendas']
  for (const resource of resources)
    await markSync(finance, resource, { last_started_at: started, last_error: null })

  const counts = {} as SyncCounts
  try {
    counts.corretores = await syncEmployees(core, finance)
    counts.empreendimentos = await syncDevelopments(core, finance)
    counts.leads = await syncClients(core, finance)
    counts.vendas = await syncSales(core, finance)

    const completed = new Date().toISOString()
    for (const resource of resources)
      await markSync(finance, resource, { last_completed_at: completed, last_success_at: completed, records_processed: counts[resource], last_error: null })

    return { startedAt: started, completedAt: completed, counts }
  }
  catch (error) {
    const message = error instanceof Error ? error.message : 'Falha desconhecida na sincronização.'
    for (const resource of resources)
      await markSync(finance, resource, { last_completed_at: new Date().toISOString(), last_error: message })
    throw createError({ statusCode: 502, message })
  }
}

export async function authorizeCoreSync(event: H3Event) {
  const config = useRuntimeConfig(event)
  const supplied = getHeader(event, 'x-integration-secret') || getHeader(event, 'authorization')?.replace(/^Bearer\s+/i, '')
  if (config.integrationSyncSecret && supplied === config.integrationSyncSecret)
    return

  await requireCompanyRole(event, PORTAL_MEMUDE_COMPANY_ID, ['super_admin', 'admin'])
}

export function verifyCoreWebhook(event: H3Event, rawBody: string) {
  const config = useRuntimeConfig(event)
  const timestamp = getHeader(event, 'x-memude-timestamp') ?? ''
  const signature = getHeader(event, 'x-memude-signature')?.replace(/^sha256=/, '') ?? ''
  const timestampSeconds = Number(timestamp)
  if (!config.coreWebhookSecret || !Number.isFinite(timestampSeconds) || Math.abs(Date.now() / 1000 - timestampSeconds) > WEBHOOK_TOLERANCE_SECONDS)
    return false
  const expected = createHmac('sha256', config.coreWebhookSecret).update(`${timestamp}.${rawBody}`).digest('hex')
  const left = Buffer.from(signature)
  const right = Buffer.from(expected)

  return left.length === right.length && timingSafeEqual(left, right)
}
