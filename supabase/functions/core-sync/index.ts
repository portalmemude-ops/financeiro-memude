import 'jsr:@supabase/functions-js/edge-runtime.d.ts'
import { createHash, createHmac, timingSafeEqual } from 'node:crypto'
import { Buffer } from 'node:buffer'
import { coreCommissionStatus, coreSaleBuyer } from '../../../utils/coreSaleMapping.ts'
import { createClient } from 'npm:@supabase/supabase-js@2.110.7'

const COMPANY_ID = '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6'
const CORE_API_URL = Deno.env.get('CORE_API_URL') ?? 'https://oxybasvtphosdmlmrfnb.supabase.co/functions/v1/finance-export'

const INTEGRATION_SYNC_SECRET = Deno.env.get('INTEGRATION_SYNC_SECRET')
const PAGE_SIZE = 500

type Resource = 'corretores' | 'empreendimentos' | 'leads' | 'vendas'

async function coreRows<T>(resource: Resource, secret: string): Promise<T[]> {
  if (!secret)
    throw new Error('Segredo da integração com o Core não configurado.')
  const rows: T[] = []
  for (let offset = 0; ; offset += PAGE_SIZE) {
    const body = JSON.stringify({ resource, offset })
    const timestamp = Math.floor(Date.now() / 1000).toString()
    const response = await fetch(CORE_API_URL, {
      method: 'POST',
      headers: { 'content-type': 'application/json', 'x-memude-timestamp': timestamp, 'x-memude-signature': 'sha256=' + createHmac('sha256', secret).update(timestamp + '.' + body).digest('hex') },
      body,
      signal: AbortSignal.timeout(30_000),
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
  for (let offset = 0; offset < payload.length; offset += PAGE_SIZE) {
    const { error } = await client.from(table).upsert(payload.slice(offset, offset + PAGE_SIZE), { onConflict })
    if (error) throw new Error(`${table}: ${error.message}`)
  }
}

async function referenceRows(client: ReturnType<typeof createClient>, table: string, column: string): Promise<any[]> {
  const rows: any[] = []
  for (let offset = 0; ; offset += PAGE_SIZE) {
    const { data, error } = await client.from(table).select(`id,${column}`)
      .eq('company_id', COMPANY_ID).order('id').range(offset, offset + PAGE_SIZE - 1)
    if (error) throw new Error(`${table}: ${error.message}`)
    rows.push(...(data ?? []))
    if ((data?.length ?? 0) < PAGE_SIZE) return rows
  }
}

// ---------------------------------------------------------------------------
// Financeiro automático das vendas do Core
// Para vendas novas (e vendas com data a partir de AUTO_FINANCE_FROM) cria:
//  - parcela da comissão (valor bruto + data prevista de pagamento)
//  - título em Contas a Receber ligado à venda
//  - divisão corretor / MeMude (% sobre a comissão líquida)
//  - conta a pagar da comissão do corretor
// Em execuções seguintes, só atualiza valores e datas enquanto os títulos estiverem em aberto.
// ---------------------------------------------------------------------------
const AUTO_FINANCE_FROM = '2026-10-31'
const FINANCE_ACCOUNT = 'Conta MeMude'

const num = (value: unknown) => Number(value ?? 0) || 0
const round2 = (value: number) => Math.round(value * 100) / 100
const brl = (value: number) => value.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })
const pct = (value: unknown) => `${num(value).toLocaleString('pt-BR', { maximumFractionDigits: 2 })}%`
const fmtDate = (value: string | null | undefined) => value ? value.slice(0, 10).split('-').reverse().join('/') : '—'

async function lookupId(client: any, table: string, name: string): Promise<string | null> {
  const { data } = await client.from(table).select('id').eq('company_id', COMPANY_ID).eq('name', name).limit(1).maybeSingle()
  return data?.id ?? null
}

async function must<T>(label: string, promise: PromiseLike<{ data: T; error: any }>): Promise<T> {
  const { data, error } = await promise
  if (error) throw new Error(`${label}: ${error.message}`)
  return data
}

async function updateIfOpen(client: any, table: 'receivables' | 'payables', id: string | null, values: Record<string, unknown>) {
  if (!id) return
  await must(`${table} update`, client.from(table).update({ ...values, updated_at: new Date().toISOString() }).eq('id', id).eq('status', 'open'))
}

async function syncSaleFinance(client: any, vendas: any[], ctx: {
  saleIds: Map<string, string>
  employeeIds: Map<string, string>
  buyers: Map<string, any>
  developmentNames: Map<string, string>
  brokerNames: Map<string, string>
  newVendaIds: Set<string>
}) {
  const commissionRows = await must<any[]>('commissions', client.from('commissions')
    .select('id, core_venda_id, commission_installments(id, status, receivable_id), commission_splits(id, beneficiary_type, payable_id)')
    .eq('company_id', COMPANY_ID).eq('source', 'memude_core'))
  const commissions = new Map((commissionRows ?? []).map(row => [row.core_venda_id, row]))
  const [receivableCategory, payableCategory, costCenter] = await Promise.all([
    lookupId(client, 'chart_accounts', 'Comissões de vendas'),
    lookupId(client, 'chart_accounts', 'Repasse de comissões'),
    lookupId(client, 'cost_centers', 'Comercial'),
  ])

  for (const row of vendas) {
    const commission = commissions.get(row.id)
    if (!commission) continue
    const eligible = ctx.newVendaIds.has(row.id) || String(row.data_venda ?? '') >= AUTO_FINANCE_FROM
    if (!eligible) continue

    const cancelled = ['cancelada', 'cancelado', 'canceled', 'cancelled'].includes(String(row.status).toLowerCase())
    const saleValue = num(row.valor_imovel)
    const gross = round2(num(row.valor_comissao_bruta) || saleValue * num(row.comissao_percentual) / 100)
    const tax = round2(num(row.valor_imposto))
    const net = round2(num(row.valor_comissao_liquida) || gross - tax)
    const brokerValue = round2(num(row.valor_corretor))
    const memudeValue = round2(num(row.valor_memude))
    const dueDate = row.data_pagamento || row.data_venda
    if (!dueDate || gross <= 0) continue

    const saleId = ctx.saleIds.get(row.id) ?? null
    const brokerId = row.corretor_id ? ctx.employeeIds.get(row.corretor_id) ?? null : null
    const brokerName = row.corretor_id ? ctx.brokerNames.get(row.corretor_id) ?? 'corretor' : 'corretor'
    const development = ctx.developmentNames.get(row.empreendimento_id) ?? 'Empreendimento'
    const buyer = ctx.buyers.get(row.lead_id)?.nome ?? 'não informado'
    const summary = [
      `VGV ${brl(saleValue)}`,
      `Comissão ${pct(row.comissao_percentual)} = ${brl(gross)}`,
      `Imposto ${pct(row.imposto_percentual)} = ${brl(tax)}`,
      `Comissão líquida ${brl(net)}`,
      `Corretor (${brokerName}) ${brl(brokerValue)}`,
      `MeMude ${brl(memudeValue)}`,
      `Data da venda ${fmtDate(row.data_venda)}`,
      `Previsão de pagamento ${fmtDate(dueDate)}`,
    ].join(' · ')

    await must('commissions notes', client.from('commissions').update({ notes: summary }).eq('id', commission.id))

    // Parcela + Contas a Receber
    let installment = (commission.commission_installments ?? [])[0]
    if (!installment && !cancelled) {
      installment = await must<any>('commission_installments', client.from('commission_installments').insert({
        commission_id: commission.id,
        installment_number: 1,
        amount: gross,
        expected_date: dueDate,
        status: 'pending',
      }).select('id, status, receivable_id').single())
      const receivable = await must<any>('receivables', client.from('receivables').insert({
        company_id: COMPANY_ID,
        sale_id: saleId,
        commission_installment_id: installment.id,
        description: `Comissão ${development} - Cliente ${buyer}`,
        amount: gross,
        due_date: dueDate,
        competence_date: row.data_venda,
        category_id: receivableCategory,
        cost_center_id: costCenter,
        invoice_rule: 'none',
        recurrence: 'once',
        status: 'open',
        account: FINANCE_ACCOUNT,
        notes: summary,
      }).select('id').single())
      await must('commission_installments link', client.from('commission_installments').update({ receivable_id: receivable.id }).eq('id', installment.id))
    }
    else if (installment) {
      if (installment.status === 'pending')
        await must('commission_installments update', client.from('commission_installments')
          .update(cancelled ? { status: 'cancelled' } : { amount: gross, expected_date: dueDate }).eq('id', installment.id))
      await updateIfOpen(client, 'receivables', installment.receivable_id,
        cancelled ? { status: 'cancelled' } : { amount: gross, due_date: dueDate, competence_date: row.data_venda, notes: summary })
    }

    // Divisão corretor / MeMude + Contas a Pagar do corretor
    const splits = commission.commission_splits ?? []
    const share = (value: number) => net > 0 ? round2(value / net * 100) : null
    const brokerSplit = splits.find((split: any) => split.beneficiary_type === 'broker')
    if (brokerValue > 0) {
      if (!brokerSplit && !cancelled) {
        const payable = await must<any>('payables', client.from('payables').insert({
          company_id: COMPANY_ID,
          employee_id: brokerId,
          description: `Comissão corretor ${brokerName} - ${development} - Cliente ${buyer}`,
          amount: brokerValue,
          due_date: dueDate,
          competence_date: row.data_venda,
          category_id: payableCategory,
          cost_center_id: costCenter,
          recurrence: 'once',
          status: 'open',
          account: FINANCE_ACCOUNT,
          notes: summary,
        }).select('id').single())
        await must('commission_splits broker', client.from('commission_splits').insert({
          commission_id: commission.id,
          beneficiary_type: 'broker',
          beneficiary_id: brokerId,
          percentage: share(brokerValue),
          amount: brokerValue,
          payable_id: payable.id,
          status: 'pending',
        }))
      }
      else if (brokerSplit) {
        await must('commission_splits broker update', client.from('commission_splits')
          .update({ beneficiary_id: brokerId, percentage: share(brokerValue), amount: brokerValue }).eq('id', brokerSplit.id).eq('status', 'pending'))
        await updateIfOpen(client, 'payables', brokerSplit.payable_id,
          cancelled ? { status: 'cancelled' } : { amount: brokerValue, due_date: dueDate, competence_date: row.data_venda, employee_id: brokerId, notes: summary })
      }
    }

    const memudeSplit = splits.find((split: any) => split.beneficiary_type === 'brokerage')
    if (memudeValue > 0) {
      if (!memudeSplit && !cancelled)
        await must('commission_splits brokerage', client.from('commission_splits').insert({
          commission_id: commission.id,
          beneficiary_type: 'brokerage',
          percentage: share(memudeValue),
          amount: memudeValue,
          status: 'pending',
        }))
      else if (memudeSplit)
        await must('commission_splits brokerage update', client.from('commission_splits')
          .update({ percentage: share(memudeValue), amount: memudeValue }).eq('id', memudeSplit.id).eq('status', 'pending'))
    }
  }
}

const corsHeaders: Record<string, string> = {
  'Access-Control-Allow-Origin': 'https://financas.memudecore.com.br',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type, x-integration-secret, x-memude-timestamp, x-memude-signature',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Vary': 'Origin',
}

Deno.serve(async request => {
  if (request.method === 'OPTIONS')
    return new Response('ok', { headers: corsHeaders })
  const response = await handleRequest(request)
  for (const [key, value] of Object.entries(corsHeaders)) response.headers.set(key, value)
  return response
})

async function handleRequest(request: Request): Promise<Response> {
  if (request.method !== 'POST')
    return Response.json({ error: 'Método não permitido.' }, { status: 405 })

  const authHeader = request.headers.get('authorization') ?? ''
  const url = Deno.env.get('SUPABASE_URL')!
  const finance = createClient(url, Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!, {
    auth: { autoRefreshToken: false, persistSession: false },
  })
  const { data: config, error: configError } = await finance.rpc('get_core_sync_config')
  if (configError || !config?.secret) return Response.json({ error: 'Credencial do Core indisponível.' }, { status: 503 })
  const raw = await request.text()
  if (raw.length > 200_000) return Response.json({ error: 'Requisição inválida.' }, { status: 400 })
  const timestamp = request.headers.get('x-memude-timestamp') || ''
  const signature = (request.headers.get('x-memude-signature') || '').replace(/^sha256=/, '')
  const expected = createHmac('sha256', config.secret).update(timestamp + '.' + raw).digest('hex')
  const signed = /^\d+$/.test(timestamp) && Math.abs(Date.now() / 1000 - Number(timestamp)) <= 300
    && /^[a-f0-9]{64}$/.test(signature) && timingSafeEqual(Buffer.from(signature), Buffer.from(expected))
  const suppliedSyncSecret = request.headers.get('x-integration-secret')
  const trustedIntegration = Boolean(INTEGRATION_SYNC_SECRET && suppliedSyncSecret === INTEGRATION_SYNC_SECRET)
  if (!trustedIntegration && !signed) {
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
    const corretores = await coreRows<any>('corretores', config.secret)
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

    const empreendimentos = await coreRows<any>('empreendimentos', config.secret)
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

    const leads = await coreRows<any>('leads', config.secret)
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

    const [localDevelopments, localEmployees] = await Promise.all([
      referenceRows(finance, 'developments', 'core_empreendimento_id'),
      referenceRows(finance, 'employees', 'core_corretor_id'),
    ])
    const developmentIds = new Map((localDevelopments ?? []).map(row => [row.core_empreendimento_id, row.id]))
    const employeeIds = new Map((localEmployees ?? []).map(row => [row.core_corretor_id, row.id]))

    // Vendas que já existiam no financeiro antes desta execução (para identificar vendas novas)
    const knownVendaIds = new Set((await referenceRows(finance, 'sales', 'core_venda_id')).map(row => row.core_venda_id))
    const vendas = await coreRows<any>('vendas', config.secret)
    const buyers = new Map(leads.map(row => [row.id, row]))
    await upsert(finance, 'sales', vendas.map(row => ({
      company_id: COMPANY_ID,
      core_venda_id: row.id,
      core_lead_id: row.lead_id,
      ...coreSaleBuyer(buyers.get(row.lead_id)),
      core_payload: row,
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

    const localSales = await referenceRows(finance, 'sales', 'core_venda_id')
    const saleIds = new Map((localSales ?? []).map(row => [row.core_venda_id, row.id]))
    await upsert(finance, 'commissions', vendas.map(row => ({
      company_id: COMPANY_ID,
      core_venda_id: row.id,
      sale_id: saleIds.get(row.id) ?? null,
      total_amount: row.valor_comissao_bruta ?? Number(row.valor_imovel) * Number(row.comissao_percentual) / 100,
      receipt_type: 'launch_passthrough',
      status: coreCommissionStatus(row.status),
      notes: 'Comissão sincronizada automaticamente do MeMude Core.',
      source: 'memude_core',
      source_updated_at: row.updated_at,
    })), 'company_id,core_venda_id')

    const developmentNames = new Map(empreendimentos.map((row: any) => [row.id, row.nome]))
    const brokerNames = new Map(corretores.map((row: any) => [row.id, `${row.profiles?.first_name ?? ''} ${row.profiles?.last_name ?? ''}`.trim() || `Corretor ${row.creci}`]))
    const newVendaIds = new Set<string>(vendas.map((row: any) => row.id).filter((id: string) => !knownVendaIds.has(id)))
    await syncSaleFinance(finance, vendas, { saleIds, employeeIds, buyers, developmentNames, brokerNames, newVendaIds })

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
}
