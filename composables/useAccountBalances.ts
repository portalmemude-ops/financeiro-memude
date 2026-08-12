import { computed } from 'vue'
import { useFinanceStore } from '@/stores/finance'
import type { Transaction } from '@/types/finance'

// ============================================================================
// Saldo por conta bancária/caixa da empresa atual. O nome da conta é texto
// livre gravado em cada lançamento (`account`), então a lista de contas é
// derivada do próprio histórico — não existe cadastro separado.
// ============================================================================

export interface AccountBalance {
  account: string
  income: number
  expense: number
  transfersIn: number
  transfersOut: number
  balance: number
  count: number
  lastMovementAt?: string
}

/** Rótulo usado quando um lançamento antigo não tem conta informada. */
export const UNASSIGNED_ACCOUNT = 'Sem conta informada'

export function accountLabel(transaction: Pick<Transaction, 'account'>): string {
  const name = (transaction.account ?? '').trim()

  return name === '' ? UNASSIGNED_ACCOUNT : name
}

export function useAccountBalances() {
  const finance = useFinanceStore()

  const balances = computed<AccountBalance[]>(() => {
    const map = new Map<string, AccountBalance>()

    for (const transaction of finance.companyTransactions) {
      const key = accountLabel(transaction)

      let row = map.get(key)
      if (!row) {
        row = { account: key, income: 0, expense: 0, transfersIn: 0, transfersOut: 0, balance: 0, count: 0 }
        map.set(key, row)
      }

      const amount = Number(transaction.amount) * (transaction.isReversal ? -1 : 1)

      if (transaction.isTransfer) {
        if (transaction.type === 'income')
          row.transfersIn += amount
        else
          row.transfersOut += amount
      }
      else if (transaction.type === 'income') {
        row.income += amount
      }
      else {
        row.expense += amount
      }

      row.balance += transactionEffect(transaction)
      row.count += 1

      const movedAt = transaction.date
      if (movedAt && (!row.lastMovementAt || movedAt > row.lastMovementAt))
        row.lastMovementAt = movedAt
    }

    return [...map.values()].sort((a, b) => b.balance - a.balance)
  })

  /** Soma dos saldos das contas — igual ao caixa total da empresa. */
  const total = computed(() => balances.value.reduce((sum, row) => sum + row.balance, 0))

  const negativeAccounts = computed(() => balances.value.filter(row => row.balance < 0))

  /** Nomes de conta já usados, para os selects de transferência. */
  const accountNames = computed(() =>
    balances.value.map(row => row.account).filter(name => name !== UNASSIGNED_ACCOUNT),
  )

  /** Transferências e ajustes, agrupados pelas duas pernas. */
  const transfers = computed(() => {
    const groups = new Map<string, Transaction[]>()

    for (const transaction of finance.companyTransactions) {
      if (!transaction.isTransfer || !transaction.transferId)
        continue
      const list = groups.get(transaction.transferId)
      if (list)
        list.push(transaction)
      else
        groups.set(transaction.transferId, [transaction])
    }

    return [...groups.entries()]
      .map(([transferId, legs]) => {
        const out = legs.find(leg => leg.type === 'expense')
        const into = legs.find(leg => leg.type === 'income')

        return {
          transferId,
          date: legs[0].date,
          amount: Number(legs[0].amount),
          description: legs[0].description,
          from: out ? accountLabel(out) : null,
          to: into ? accountLabel(into) : null,
          isAdjustment: !out || !into,
        }
      })
      .sort((a, b) => b.date.localeCompare(a.date))
  })

  return { balances, total, negativeAccounts, accountNames, transfers }
}
