export function coreCommissionStatus(status: string): string {
  if (status === 'pago')
    return 'received'
  if (status === 'cancelado' || status === 'cancelada')
    return 'cancelled'

  return 'pending'
}

export function coreSaleBuyer(lead: { nome?: string | null; telefone?: string | null; email?: string | null } | undefined) {
  return { buyer_name: lead?.nome || null, buyer_contact: lead?.telefone || lead?.email || null }
}
