<script setup lang="ts">
import { useFinanceStore } from '@/stores/finance'
import { useAppStore } from '@/stores/app'
import { UNASSIGNED_ACCOUNT, useAccountBalances } from '@/composables/useAccountBalances'

const finance = useFinanceStore()
const app = useAppStore()
const { balances, total, negativeAccounts, accountNames, transfers } = useAccountBalances()

useHead({ title: 'Contas e Saldos' })

const headers = [
  { title: 'Conta', key: 'account' },
  { title: 'Entradas', key: 'income', align: 'end' as const },
  { title: 'Saídas', key: 'expense', align: 'end' as const },
  { title: 'Transferências', key: 'transfers', align: 'end' as const, sortable: false },
  { title: 'Saldo', key: 'balance', align: 'end' as const },
  { title: 'Últ. movimento', key: 'lastMovementAt' },
]

const transferHeaders = [
  { title: 'Data', key: 'date' },
  { title: 'Origem', key: 'from' },
  { title: 'Destino', key: 'to' },
  { title: 'Descrição', key: 'description' },
  { title: 'Valor', key: 'amount', align: 'end' as const },
  { title: '', key: 'actions', sortable: false, align: 'end' as const },
]

// 👉 Diálogo de transferência / ajuste
type Mode = 'transfer' | 'adjustment'

const dialog = ref(false)
const formRef = ref()
const mode = ref<Mode>('transfer')
const saving = ref(false)

const form = ref({
  fromAccount: '' as string | null,
  toAccount: '' as string | null,
  amount: undefined as number | undefined,
  date: todayISO(),
  notes: '',
})

const snackbar = ref(false)
const snackbarText = ref('')
const snackbarColor = ref<'success' | 'error'>('success')

function showMessage(text: string, color: 'success' | 'error' = 'success') {
  snackbarText.value = text
  snackbarColor.value = color
  snackbar.value = true
}

// Lista simples de strings: o VCombobox devolve sempre texto, inclusive quando
// o usuário digita uma conta que ainda não existe.
const accountItems = computed<string[]>(() => accountNames.value)

// Exclusão apaga lançamentos de caixa: restrita a administradores (o RPC também exige).
const canDeleteTransfer = computed(() => ['super_admin', 'admin'].includes(app.currentRole))

function openNew(next: Mode) {
  mode.value = next
  form.value = { fromAccount: null, toAccount: null, amount: undefined, date: todayISO(), notes: '' }
  dialog.value = true
}

/** Prévia do saldo das contas envolvidas depois do lançamento. */
const preview = computed(() => {
  const amount = Number(form.value.amount ?? 0)
  if (!amount)
    return []
  const rows: { account: string; before: number; after: number }[] = []
  const balanceOf = (name: string) => balances.value.find(row => row.account === name)?.balance ?? 0

  if (form.value.fromAccount)
    rows.push({ account: form.value.fromAccount, before: balanceOf(form.value.fromAccount), after: balanceOf(form.value.fromAccount) - amount })
  if (form.value.toAccount)
    rows.push({ account: form.value.toAccount, before: balanceOf(form.value.toAccount), after: balanceOf(form.value.toAccount) + amount })

  return rows
})

const sidesFilled = computed(() =>
  mode.value === 'transfer'
    ? Boolean(form.value.fromAccount && form.value.toAccount)
    : Boolean(form.value.fromAccount || form.value.toAccount),
)

async function save() {
  const { valid } = await formRef.value.validate()
  if (!valid || !sidesFilled.value)
    return
  saving.value = true
  try {
    await finance.registerAccountTransfer({
      fromAccount: form.value.fromAccount || undefined,
      toAccount: form.value.toAccount || undefined,
      amount: Number(form.value.amount),
      date: form.value.date,
      notes: form.value.notes || undefined,
    })
    dialog.value = false
    showMessage(mode.value === 'transfer'
      ? 'Transferência registrada. Os saldos das contas foram atualizados.'
      : 'Ajuste de saldo registrado.')
  }
  catch (error) {
    showMessage(error instanceof Error ? error.message : 'Não foi possível registrar o lançamento.', 'error')
  }
  finally {
    saving.value = false
  }
}

// 👉 Exclusão de transferência
const deleteDialog = ref(false)
const deleteTarget = ref<{ transferId: string; description: string } | null>(null)

function askDelete(row: { transferId: string; description: string }) {
  deleteTarget.value = row
  deleteDialog.value = true
}

async function doDelete() {
  if (!deleteTarget.value)
    return
  try {
    await finance.deleteAccountTransfer(deleteTarget.value.transferId)
    showMessage('Transferência excluída e saldos recalculados.')
  }
  catch (error) {
    showMessage(error instanceof Error ? error.message : 'Não foi possível excluir.', 'error')
  }
  finally {
    deleteTarget.value = null
  }
}
</script>

<template>
  <div>
    <AppPageHeader
      title="Contas e Saldos"
      subtitle="Saldo de cada conta bancária e transferências entre elas"
      icon="ri-bank-line"
    >
      <template #actions>
        <VBtn
          v-if="app.canManageFinance"
          variant="tonal"
          color="secondary"
          prepend-icon="ri-scales-3-line"
          class="me-2"
          @click="openNew('adjustment')"
        >
          Ajuste de saldo
        </VBtn>
        <VBtn
          v-if="app.canManageFinance"
          prepend-icon="ri-arrow-left-right-line"
          @click="openNew('transfer')"
        >
          Nova transferência
        </VBtn>
      </template>
    </AppPageHeader>

    <VRow class="match-height mb-1">
      <VCol
        cols="12"
        sm="6"
        lg="3"
      >
        <KpiCard
          title="Caixa total"
          :value="formatBRL(total)"
          icon="ri-wallet-3-line"
          :color="total >= 0 ? 'success' : 'error'"
          subtitle="Soma de todas as contas"
        />
      </VCol>
      <VCol
        cols="12"
        sm="6"
        lg="3"
      >
        <KpiCard
          title="Contas ativas"
          :value="String(balances.length)"
          icon="ri-bank-line"
          color="info"
          subtitle="Com movimento registrado"
        />
      </VCol>
      <VCol
        cols="12"
        sm="6"
        lg="3"
      >
        <KpiCard
          title="Contas negativas"
          :value="String(negativeAccounts.length)"
          icon="ri-error-warning-line"
          :color="negativeAccounts.length ? 'error' : 'success'"
          subtitle="Saldo abaixo de zero"
        />
      </VCol>
      <VCol
        cols="12"
        sm="6"
        lg="3"
      >
        <KpiCard
          title="Transferências"
          :value="String(transfers.length)"
          icon="ri-arrow-left-right-line"
          color="primary"
          subtitle="Movimentações entre contas"
        />
      </VCol>
    </VRow>

    <VAlert
      v-if="negativeAccounts.length"
      type="warning"
      variant="tonal"
      class="mb-4"
    >
      <div class="font-weight-medium mb-1">
        {{ negativeAccounts.length }} conta(s) com saldo negativo
      </div>
      Um saldo negativo normalmente significa que faltam lançamentos — em geral
      transferências entre contas que aconteceram no banco mas não foram registradas.
      Use “Nova transferência” para regularizar.
    </VAlert>

    <VCard class="mb-6">
      <VCardItem>
        <VCardTitle>Saldo por conta</VCardTitle>
      </VCardItem>
      <VDivider />
      <VDataTable
        :headers="headers"
        :items="balances"
        :items-per-page="10"
        item-value="account"
        class="text-no-wrap"
      >
        <template #item.account="{ item }">
          <div class="py-2">
            <div class="font-weight-medium">
              {{ item.account }}
            </div>
            <div class="text-caption text-disabled">
              {{ item.count }} lançamento(s)
              <template v-if="item.account === UNASSIGNED_ACCOUNT">
                · sem banco informado
              </template>
            </div>
          </div>
        </template>
        <template #item.income="{ item }">
          <span class="text-success">{{ formatBRL(item.income) }}</span>
        </template>
        <template #item.expense="{ item }">
          <span class="text-error">{{ formatBRL(item.expense) }}</span>
        </template>
        <template #item.transfers="{ item }">
          <div
            v-if="item.transfersIn || item.transfersOut"
            class="text-end"
          >
            <div
              v-if="item.transfersIn"
              class="text-caption text-success"
            >
              + {{ formatBRL(item.transfersIn) }}
            </div>
            <div
              v-if="item.transfersOut"
              class="text-caption text-error"
            >
              − {{ formatBRL(item.transfersOut) }}
            </div>
          </div>
          <span
            v-else
            class="text-disabled"
          >—</span>
        </template>
        <template #item.balance="{ item }">
          <span
            class="font-weight-medium"
            :class="item.balance < 0 ? 'text-error' : 'text-high-emphasis'"
          >
            {{ formatBRL(item.balance) }}
          </span>
        </template>
        <template #item.lastMovementAt="{ item }">
          {{ formatDate(item.lastMovementAt) }}
        </template>
        <template #body.append>
          <tr class="font-weight-bold">
            <td>Total</td>
            <td class="text-end">
              {{ formatBRL(balances.reduce((s, r) => s + r.income, 0)) }}
            </td>
            <td class="text-end">
              {{ formatBRL(balances.reduce((s, r) => s + r.expense, 0)) }}
            </td>
            <td />
            <td class="text-end">
              {{ formatBRL(total) }}
            </td>
            <td />
          </tr>
        </template>
        <template #no-data>
          <div class="text-center py-8 text-disabled">
            Nenhum lançamento registrado ainda
          </div>
        </template>
      </VDataTable>
    </VCard>

    <VCard>
      <VCardItem>
        <VCardTitle>Transferências e ajustes</VCardTitle>
        <template #append>
          <span class="text-caption text-disabled">Não entram no resultado (DRE)</span>
        </template>
      </VCardItem>
      <VDivider />
      <VDataTable
        :headers="transferHeaders"
        :items="transfers"
        :items-per-page="10"
        item-value="transferId"
        class="text-no-wrap"
      >
        <template #item.date="{ item }">
          {{ formatDate(item.date) }}
        </template>
        <template #item.from="{ item }">
          <span v-if="item.from">{{ item.from }}</span>
          <VChip
            v-else
            size="small"
            label
            color="info"
          >
            Ajuste de entrada
          </VChip>
        </template>
        <template #item.to="{ item }">
          <span v-if="item.to">{{ item.to }}</span>
          <VChip
            v-else
            size="small"
            label
            color="warning"
          >
            Ajuste de saída
          </VChip>
        </template>
        <template #item.amount="{ item }">
          <span class="font-weight-medium">{{ formatBRL(item.amount) }}</span>
        </template>
        <template #item.actions="{ item }">
          <IconBtn
            v-if="canDeleteTransfer"
            color="error"
            aria-label="Excluir transferência"
            @click="askDelete(item)"
          >
            <VIcon icon="ri-delete-bin-line" />
            <VTooltip activator="parent">
              Excluir transferência
            </VTooltip>
          </IconBtn>
        </template>
        <template #no-data>
          <div class="text-center py-8 text-disabled">
            Nenhuma transferência registrada
          </div>
        </template>
      </VDataTable>
    </VCard>

    <!-- Dialog transferência / ajuste -->
    <VDialog
      v-model="dialog"
      max-width="560"
      persistent
    >
      <VCard>
        <VCardItem>
          <VCardTitle>
            {{ mode === 'transfer' ? 'Nova transferência entre contas' : 'Ajuste de saldo' }}
          </VCardTitle>
        </VCardItem>
        <VCardText>
          <VAlert
            type="info"
            variant="tonal"
            density="compact"
            class="mb-4"
          >
            <template v-if="mode === 'transfer'">
              O dinheiro sai de uma conta e entra na outra. O caixa total não muda
              e nada disso aparece como receita ou despesa nos relatórios.
            </template>
            <template v-else>
              Use para acertar o saldo de uma conta quando faltam lançamentos antigos.
              Altera o caixa da conta, mas não entra no resultado.
            </template>
          </VAlert>

          <VForm
            ref="formRef"
            @submit.prevent="save"
          >
            <VRow>
              <VCol
                cols="12"
                md="6"
              >
                <VCombobox
                  v-model="form.fromAccount"
                  label="Conta de origem (sai)"
                  :items="accountItems"
                  :rules="mode === 'transfer' ? [requiredRule] : []"
                  clearable
                  :hint="mode === 'transfer' ? 'Pode digitar um nome novo' : 'Preencha só se o saldo deve DIMINUIR'"
                  persistent-hint
                />
              </VCol>
              <VCol
                cols="12"
                md="6"
              >
                <VCombobox
                  v-model="form.toAccount"
                  label="Conta de destino (entra)"
                  :items="accountItems"
                  :rules="mode === 'transfer' ? [requiredRule] : []"
                  clearable
                  :hint="mode === 'transfer' ? 'Pode digitar um nome novo' : 'Preencha só se o saldo deve AUMENTAR'"
                  persistent-hint
                />
              </VCol>
              <VCol
                cols="12"
                md="6"
              >
                <VTextField
                  v-model.number="form.amount"
                  label="Valor (R$)"
                  type="number"
                  prefix="R$"
                  :rules="[requiredRule, positiveRule]"
                />
              </VCol>
              <VCol
                cols="12"
                md="6"
              >
                <VTextField
                  v-model="form.date"
                  label="Data"
                  type="date"
                  :rules="[requiredRule]"
                />
              </VCol>
              <VCol cols="12">
                <VTextField
                  v-model="form.notes"
                  label="Descrição (opcional)"
                  placeholder="Ex.: transferência para pagamento da folha"
                />
              </VCol>
              <VCol
                v-if="mode === 'adjustment' && !sidesFilled"
                cols="12"
              >
                <VAlert
                  type="warning"
                  variant="tonal"
                  density="compact"
                >
                  Informe a conta que entra (para aumentar o saldo) ou a que sai (para diminuir).
                </VAlert>
              </VCol>
              <VCol
                v-if="preview.length"
                cols="12"
              >
                <VCard
                  variant="tonal"
                  color="secondary"
                >
                  <VCardText class="py-3">
                    <div class="text-caption mb-2">
                      Como os saldos ficam:
                    </div>
                    <div
                      v-for="row in preview"
                      :key="row.account"
                      class="d-flex justify-space-between text-body-2"
                    >
                      <span>{{ row.account }}</span>
                      <span>
                        {{ formatBRL(row.before) }} →
                        <strong :class="row.after < 0 ? 'text-error' : 'text-success'">
                          {{ formatBRL(row.after) }}
                        </strong>
                      </span>
                    </div>
                  </VCardText>
                </VCard>
              </VCol>
            </VRow>
          </VForm>
        </VCardText>
        <VCardText class="d-flex justify-end gap-3 pt-0">
          <VBtn
            variant="tonal"
            color="secondary"
            @click="dialog = false"
          >
            Cancelar
          </VBtn>
          <VBtn
            :loading="saving"
            :disabled="saving || !sidesFilled"
            @click="save"
          >
            Registrar
          </VBtn>
        </VCardText>
      </VCard>
    </VDialog>

    <ConfirmDialog
      v-model="deleteDialog"
      title="Excluir transferência"
      :message="`A transferência '${deleteTarget?.description}' será removida e os saldos das contas recalculados. Deseja continuar?`"
      confirm-text="Excluir"
      confirm-color="error"
      @confirm="doDelete"
    />

    <VSnackbar
      v-model="snackbar"
      :color="snackbarColor"
      timeout="5000"
    >
      {{ snackbarText }}
    </VSnackbar>
  </div>
</template>
