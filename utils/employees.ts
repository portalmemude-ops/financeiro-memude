import type { Employee } from '@/types/finance'

/**
 * Quem pode ser escolhido como corretor numa venda, no funil e no portal.
 *
 * O vínculo "Comissionado" descreve o corretor autônomo, mas não é o único
 * caso: existe quem seja CLT ou PJ e também venda. Por isso o cargo conta —
 * assim um colaborador PJ com cargo de corretor aparece nas telas comerciais
 * sem que o cadastro precise mentir sobre o vínculo dele.
 */
export function isBrokerEmployee(employee: Pick<Employee, 'employmentType' | 'roleTitle'>): boolean {
  if (employee.employmentType === 'commission_only')
    return true

  return /corretor/i.test(employee.roleTitle ?? '')
}
