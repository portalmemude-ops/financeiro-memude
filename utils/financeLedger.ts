import type { Receivable, Transaction } from '@/types/finance'

export function receivableOutstanding(receivable: Pick<Receivable, 'amount' | 'receivedAmount'>): number {
  return Math.max(0, Number(receivable.amount) - Number(receivable.receivedAmount ?? 0))
}

export function isReceivablePending(receivable: Pick<Receivable, 'status'>): boolean {
  return ['open', 'partial', 'overdue'].includes(receivable.status)
}

export function transactionEffect(transaction: Pick<Transaction, 'type' | 'amount' | 'isReversal'>): number {
  const direction = transaction.type === 'income' ? 1 : -1

  return Number(transaction.amount) * direction * (transaction.isReversal ? -1 : 1)
}

/**
 * Nem todo dinheiro que entra é faturamento. Aporte de sócio é capital, e
 * transferência entre contas é o mesmo dinheiro mudando de lugar: os dois
 * movimentam o caixa mas ficam fora do faturamento, do DRE, do realizado do
 * mês, do balancete e dos centros de custo.
 *
 * O banco resolve isso em `in_result` (a partir da conta do plano e da marca de
 * transferência), então aqui basta respeitar a marca. Lançamentos antigos, sem
 * o campo preenchido, contam no resultado — que era o comportamento anterior.
 */
export function countsInResult(transaction: Pick<Transaction, 'inResult' | 'isTransfer'>): boolean {
  if (transaction.isTransfer)
    return false

  return transaction.inResult !== false
}

export function transactionIncome(transaction: Pick<Transaction, 'type' | 'amount' | 'isReversal' | 'isTransfer' | 'inResult'>): number {
  if (transaction.type !== 'income' || !countsInResult(transaction))
    return 0

  return Number(transaction.amount) * (transaction.isReversal ? -1 : 1)
}

export function transactionExpense(transaction: Pick<Transaction, 'type' | 'amount' | 'isReversal' | 'isTransfer' | 'inResult'>): number {
  if (transaction.type !== 'expense' || !countsInResult(transaction))
    return 0

  return Number(transaction.amount) * (transaction.isReversal ? -1 : 1)
}
