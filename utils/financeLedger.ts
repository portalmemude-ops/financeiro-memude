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

export function transactionIncome(transaction: Pick<Transaction, 'type' | 'amount' | 'isReversal'>): number {
  if (transaction.type !== 'income')
    return 0

  return Number(transaction.amount) * (transaction.isReversal ? -1 : 1)
}

export function transactionExpense(transaction: Pick<Transaction, 'type' | 'amount' | 'isReversal'>): number {
  if (transaction.type !== 'expense')
    return 0

  return Number(transaction.amount) * (transaction.isReversal ? -1 : 1)
}
