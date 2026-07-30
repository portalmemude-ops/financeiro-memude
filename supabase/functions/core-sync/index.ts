import 'jsr:@supabase/functions-js/edge-runtime.d.ts'
import { createHash } from 'node:crypto'
import { createClient } from 'npm:@supabase/supabase-js@2'

const COMPANY_ID = '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6'
const CORE_API_URL = Deno.env.get('CORE_API_URL') ?? 'https://oxybasvtphosdmlmrfnb.supabase.co/functions/v1/finance-export'
const CORE_API_SECRET = Deno.env.get('CORE_API_SECRET')
const INTEGRATION_SYNC_SECRET = Deno.env.get('INTEGRATION_SYNC_SECRET')
const PAGE_SIZE = 500

type Resource = 'corretores' | 'empreendimentos' | 'leads' | 'vendas'

async function coreRows<T>(resource: Resource): Promise<T[]> {
  if (!CORE_API_SECRET)
    throw new Error('Segredo da integração com o Core não configurado.')
  const rows: T[] = []
  for (let offset = 0; ; offset += PAGE_SIZE) {
    const response = await fetch(CORE_API_URL, {
      method: 'POST',
      headers: { 'content-type': 'application/json', 'x-finance-export-secret': CORE_API_SECRET },
      body: JSON.stringify({ resource, offset }),
    })
    const payload = await response.json() as { data?: T[]; error?: string }
    if (!response.ok)
      throw new Error(payload.error ?? `Core respondeu HTTP ${response.status}.`)
    const page = payload.data ?? []
    rows.push(...page)
    if (page.length < PAGE_SIZE)
      return rows
  }
}

async function upsert(client: ReturnType<typeof createClient>, table: string, payload: unknown[], onConflict: string) {
  if (!payload.length)
    return
  const { error } = await client.from(table).upsert(payload, { onConflict })
  if (error)
    throw new Error(`${table}: ${error.message}`)
}

Deno.serve(async request => {
  if (request.method !== 'POST')
    return Response.json({ error: 'Método não permitido.' }, { status: 405 })

  const authHeader = request.headers.get('authorization') ?? ''
  const url = Deno.env.get('SUPABASE_URL')!
  const finance = createClient(url, Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!, {
    auth: { autoRefreshToken: false, persistSession: false },
  })
  const suppliedSyncSecret = request.headers.get('x-integration-secret')
  const trustedIntegration = Boolean(INTEGRATION_SYNC_SECRET && suppliedSyncSecret === INTEGRATION_SYNC_SECRET)
  if (!trustedIntegration) {
    const { data: auth, error: authError } = await finance.auth.getUser(authHeader.replace(/^Bearer\s+/i, ''))
    if (authError || !auth.user)
      return Response.json({ error: 'Não autenticado.' }, { status: 401 })

    const { data: membership } = await finance.from('company_members').select('role')
      .eq('company_id', COMPANY_ID).eq('user_id', auth.user.id).maybeSingle()
    if (!membership || !['super_admin', 'admin'].includes(membership.role))
      return Response.json({ error: 'Acesso negado.' }, { status: 403 })
  }

  const resources: Resource[] = ['corretores', 'empreendimentos', 'leads', 'vendas']
  const startedAt = new Date().toISOString()
  await finance.from('integration_sync_state')
    .update({ last_started_at: startedAt, last_error: null, updated_at: startedAt })
    .eq('company_id', COMPANY_ID).eq('source', 'memude_core')

  try {
    const corretores = await coreRows<any>('corretores')
    await upsert(finance, 'employees', corretores.map(row => ({
      company_id: COMPANY_ID,
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
    })), 'company_id,core_corretor_id')

    const empreendimentos = await coreRows<any>('empreendimentos')
    await upsert(finance, 'developments', empreendimentos.map(row => ({
      company_id: COMPANY_ID,
      core_empreendimento_id: row.id,
      name: row.nome,
      address: row.endereco,
      type: 'launch',
      is_active: row.ativo !== false,
      notes: [row.tipo_imovel, row.descricao].filter(Boolean).join(' — ') || null,
      source: 'memude_core',
      source_updated_at: row.updated_at,
    })), 'company_id,core_empreendimento_id')

    const leads = await coreRows<any>('leads')
    await upsert(finance, 'clients', leads.map(row => ({
      company_id: COMPANY_ID,
      core_lead_id: row.id,
      name: row.nome,
      email: row.email,
      phone: row.telefone,
      notes: [row.origem && `Origem: ${row.origem}`, row.status && `Status Core: ${row.status}`, row.observacoes].filter(Boolean).join(' — ') || null,
      is_active: !row.deleted_at,
      source: 'memude_core',
      source_updated_at: row.updated_at,
    })), 'company_id,core_lead_id')

    const [{ data: localDevelopments }, { data: localEmployees }] = await Promise.all([
      finance.from('developments').select('id,core_empreendimento_id').eq('company_id', COMPANY_ID),
      finance.from('employees').select('id,core_corretor_id').eq('company_id', COMPANY_ID),
    ])
    const developmentIds = new Map((localDevelopments ?? []).map(row => [row.core_empreendimento_id, row.id]))
    const employeeIds = new Map((localEmployees ?? []).map(row => [row.core_corretor_id, row.id]))
    const vendas = await coreRows<any>('vendas')
    await upsert(finance, 'sales', vendas.map(row => ({
      company_id: COMPANY_ID,
      core_venda_id: row.id,
      core_lead_id: row.lead_id,
      development_id: developmentIds.get(row.empreendimento_id) ?? null,
      broker_id: row.corretor_id ? employeeIds.get(row.corretor_id) ?? null : null,
      sale_value: row.valor_imovel,
      sale_date: row.data_venda,
      status: ['cancelada', 'cancelado', 'canceled', 'cancelled'].includes(String(row.status).toLowerCase()) ? 'cancelled' : 'completed',
      notes: row.observacoes,
      source: 'memude_core',
      source_updated_at: row.updated_at,
      sync_hash: createHash('sha256').update(JSON.stringify(row)).digest('hex'),
    })), 'company_id,core_venda_id')

    const { data: localSales } = await finance.from('sales').select('id,core_venda_id').eq('company_id', COMPANY_ID)
    const saleIds = new Map((localSales ?? []).map(row => [row.core_venda_id, row.id]))
    await upsert(finance, 'commissions', vendas.map(row => ({
      company_id: COMPANY_ID,
      core_venda_id: row.id,
      sale_id: saleIds.get(row.id) ?? null,
      total_amount: row.valor_comissao_bruta ?? Number(row.valor_imovel) * Number(row.comissao_percentual) / 100,
      receipt_type: 'launch_passthrough',
      status: row.data_pagamento ? 'received' : 'pending',
      notes: 'Comissão sincronizada automaticamente do MeMude Core.',
      source: 'memude_core',
      source_updated_at: row.updated_at,
    })), 'company_id,core_venda_id')

    const counts = { corretores: corretores.length, empreendimentos: empreendimentos.length, leads: leads.length, vendas: vendas.length }
    const completedAt = new Date().toISOString()
    for (const resource of resources) {
      await finance.from('integration_sync_state').update({
        last_completed_at: completedAt,
        last_success_at: completedAt,
        last_error: null,
        records_processed: counts[resource],
        updated_at: completedAt,
      }).eq('company_id', COMPANY_ID).eq('source', 'memude_core').eq('resource', resource)
    }
    return Response.json({ startedAt, completedAt, counts })
  }
  catch (error) {
    const message = error instanceof Error ? error.message : 'Falha desconhecida.'
    await finance.from('integration_sync_state')
      .update({ last_completed_at: new Date().toISOString(), last_error: message, updated_at: new Date().toISOString() })
      .eq('company_id', COMPANY_ID).eq('source', 'memude_core')
    return Response.json({ error: message }, { status: 502 })
  }
})
