// ============================================================================
// Carrega TODOS os dados do usuário autenticado a partir do Supabase e devolve
// já no formato dos stores (camelCase). O RLS por empresa garante que só vêm
// as empresas/linhas às quais o usuário tem acesso.
// ============================================================================
import type { Company, Role, UserProfile } from '@/types/finance'
import type { Database } from '@/types/database.types'

const toCamel = (s: string) => s.replace(/_([a-z])/g, (_, c: string) => c.toUpperCase())

function camelizeRow<T = Record<string, unknown>>(row: Record<string, unknown>): T {
  const out: Record<string, unknown> = {}
  for (const k in row) out[toCamel(k)] = row[k]

  return out as T
}

const camelizeRows = (rows: unknown): Record<string, unknown>[] =>
  ((rows as Record<string, unknown>[]) ?? []).map(r => camelizeRow(r))

export interface AppData {
  companies: Company[]
  currentUser: UserProfile
  finance: Record<string, unknown[]>
}

const CORE_TABLES = [
  'companies',
  'company_members',
  'user_profiles',
  'chart_accounts',
  'cost_centers',
  'suppliers',
  'employees',
  'clients',
  'developments',
  'sales',
  'commissions',
  'commission_installments',
  'commission_splits',
  'payables',
  'receivables',
  'transactions',
] as const

const OPTIONAL_TABLES = [
  'funnel_cards', 'funnel_history', 'invoices', 'notifications', 'notification_rules', 'settlements',
] as const

const TABLES = [...CORE_TABLES, ...OPTIONAL_TABLES] as const

function mapSuppliers(rows: Record<string, unknown>[]) {
  return camelizeRows(rows).map(row => {
    const documentNumber = String(row.document ?? '')

    return {
      ...row,
      documentNumber,
      documentType: documentNumber.replace(/\D/g, '').length === 11 ? 'cpf' : 'cnpj',
      bankInfo: row.bankInfo ?? {},
    }
  })
}

function mapEmployees(rows: Record<string, unknown>[]) {
  return camelizeRows(rows).map(row => ({
    ...row,
    cpf: String(row.document ?? ''),
    baseSalary: row.salary,
    bankInfo: row.bankInfo ?? {},
  }))
}

function mapInvoices(rows: Record<string, unknown>[]) {
  return camelizeRows(rows).map(row => ({
    ...row,
    invoiceNumber: row.nfseNumber,
    rpsNumber: row.rpsNumber == null ? undefined : String(row.rpsNumber),
    lc116Item: row.serviceCode,
    cnae: row.serviceCode ?? '',
    verificationCode: row.verificationCode,
    xmlBase64: row.xmlResponse,
  }))
}

function mapCompanies(rows: Record<string, unknown>[]) {
  return camelizeRows(rows).map(row => ({
    ...row,
    address: {
      street: row.addressLine,
      neighborhood: row.neighborhood,
      cityName: row.city,
      cityIbge: row.cityIbge,
      state: row.state,
      zipCode: row.postalCode,
    },
    invoiceConfig: row.invoiceConfig ?? {
      defaultCnae: '',
      defaultIssRate: 0,
      defaultServiceDescription: '',
      rpsSeries: '1',
    },
  }))
}

async function fetchAllRows(supabase: ReturnType<typeof useSupabaseClient<Database>>, table: string) {
  const pageSize = 500
  const rows: Record<string, unknown>[] = []

  for (let from = 0; ; from += pageSize) {
    const { data, error } = await supabase
      .from(table as any)
      .select('*')
      .range(from, from + pageSize - 1)

    if (error)
      return { data: rows, error }

    const page = (data as unknown as Record<string, unknown>[]) ?? []

    rows.push(...page)
    if (page.length < pageSize)
      return { data: rows, error: null }
  }
}

export async function loadAppData(): Promise<AppData | null> {
  const supabase = useSupabaseClient()
  const user = useSupabaseUser()
  if (!user.value)
    return null

  const results = await Promise.all(TABLES.map(t => fetchAllRows(supabase, t)))
  const data: Record<string, Record<string, unknown>[]> = {}

  TABLES.forEach((t, i) => {
    const optional = (OPTIONAL_TABLES as readonly string[]).includes(t)
    if (results[i].error && !optional)
      throw results[i].error
    data[t] = (results[i].data as unknown as Record<string, unknown>[]) ?? []
  })

  const companies = mapCompanies(data.companies) as unknown as Company[]

  const members = data.company_members as unknown as { user_id: string; company_id: string; role: Role }[]
  const profile = data.user_profiles.find(p => p.id === user.value!.id) as Record<string, unknown> | undefined

  const currentUser: UserProfile = {
    id: user.value.id,
    fullName: (profile?.full_name as string) || (profile?.email as string) || (user.value.email ?? 'Usuário'),
    email: (profile?.email as string) || (user.value.email ?? ''),
    phone: (profile?.phone as string) || undefined,
    avatarColor: 'primary',
    roles: members
      .filter(m => m.user_id === user.value!.id)
      .map(m => ({ companyId: m.company_id, role: m.role })),
  }

  // Fallback robusto: se os vínculos não vieram na leitura direta da tabela,
  // busca-os pela RPC my_memberships() (sempre exposta; RLS aplica).
  if (currentUser.roles.length === 0) {
    const { data: cm, error: cmErr } = await (supabase.rpc as any)('my_memberships')
    if (cm?.length)
      currentUser.roles = (cm as { company_id: string; role: Role }[]).map(m => ({ companyId: m.company_id, role: m.role }))
    if (cmErr)
      console.warn('[loadAppData] memberships RPC indisponível:', cmErr.message)
  }

  // Fixups: colunas ausentes no banco que o app espera com default.
  const withActive = (rows: Record<string, unknown>[]) => rows.map(r => ({ isActive: true, ...r }))

  return {
    companies,
    currentUser,
    finance: {
      chartAccounts: withActive(camelizeRows(data.chart_accounts)),
      costCenters: withActive(camelizeRows(data.cost_centers)),
      suppliers: mapSuppliers(data.suppliers),
      employees: mapEmployees(data.employees),
      clients: camelizeRows(data.clients),
      developments: camelizeRows(data.developments),
      sales: camelizeRows(data.sales),
      commissions: camelizeRows(data.commissions),
      commissionInstallments: camelizeRows(data.commission_installments),
      commissionSplits: camelizeRows(data.commission_splits),
      payables: camelizeRows(data.payables),
      receivables: camelizeRows(data.receivables),
      transactions: camelizeRows(data.transactions),
      settlements: camelizeRows(data.settlements),
      funnelCards: camelizeRows(data.funnel_cards),
      funnelHistory: camelizeRows(data.funnel_history),
      invoices: mapInvoices(data.invoices),
      notifications: camelizeRows(data.notifications),
      notificationRules: camelizeRows(data.notification_rules),
    },
  }
}
