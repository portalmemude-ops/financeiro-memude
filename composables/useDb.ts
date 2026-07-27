// ============================================================================
// Camada de ESCRITA no Supabase (Fase 3). Cada create insere no banco (RLS por
// empresa garante a permissão — qualquer membro da empresa pode gravar),
// injeta company_id, e atualiza o store local para refletir na UI na hora.
// ============================================================================
import { useFinanceStore } from '@/stores/finance'
import { useAppStore } from '@/stores/app'

const toCamel = (s: string) => s.replace(/_([a-z])/g, (_, c: string) => c.toUpperCase())
function camelize(row: Record<string, unknown>): any {
  const out: Record<string, unknown> = {}
  for (const k in row) out[toCamel(k)] = row[k]

  return out
}

/** Remove chaves undefined/'' para não gravar vazio à toa. */
function clean(obj: Record<string, unknown>): Record<string, unknown> {
  const out: Record<string, unknown> = {}
  for (const k in obj) {
    const v = obj[k]
    if (v !== undefined && v !== null && v !== '')
      out[k] = v
  }

  return out
}

export function useDb() {
  const supabase = useSupabaseClient()
  const app = useAppStore()
  const finance = useFinanceStore()
  const cid = () => app.currentCompanyId

  async function insert(table: string, payload: Record<string, unknown>, target: unknown[]) {
    const { data, error } = await supabase
      .from(table)
      .insert({ company_id: cid(), ...clean(payload) })
      .select()
      .single()
    if (error)
      throw error
    const row = camelize(data as Record<string, unknown>)
    target.unshift(row)

    return row
  }

  return {
    createClient: (i: Record<string, unknown>) => insert('clients', {
      name: i.name, document: i.document, email: i.email, phone: i.phone,
      city: i.city, state: i.state, notes: i.notes, is_active: true,
    }, finance.clients),

    createSupplier: (i: Record<string, unknown>) => insert('suppliers', {
      legal_name: i.legalName, trade_name: i.tradeName, document: i.document,
      email: i.email, phone: i.phone, is_active: true, notes: i.notes,
    }, finance.suppliers),

    createEmployee: (i: Record<string, unknown>) => insert('employees', {
      full_name: i.fullName, employment_type: i.employmentType, status: 'active',
      salary: i.salary, email: i.email, phone: i.phone, document: i.document, role_title: i.roleTitle,
    }, finance.employees),

    createPayable: (i: Record<string, unknown>) => insert('payables', {
      description: i.description, amount: i.amount, due_date: i.dueDate,
      category_id: i.categoryId, cost_center_id: i.costCenterId,
      supplier_id: i.supplierId, employee_id: i.employeeId,
      status: i.status ?? 'open', recurrence: i.recurrence ?? 'once', payment_method: i.paymentMethod,
    }, finance.payables),

    createReceivable: (i: Record<string, unknown>) => insert('receivables', {
      description: i.description, amount: i.amount, due_date: i.dueDate,
      client_name: i.clientName, category_id: i.categoryId, cost_center_id: i.costCenterId,
      invoice_rule: i.invoiceRule ?? 'none', recurrence: i.recurrence ?? 'once', status: i.status ?? 'open',
    }, finance.receivables),
  }
}
