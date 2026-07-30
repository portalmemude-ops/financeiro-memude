<script setup lang="ts">
interface SyncResource {
  resource: string
  last_started_at: string | null
  last_completed_at: string | null
  last_success_at: string | null
  last_error: string | null
  records_processed: number
}

const loading = ref(false)
const message = ref('')
const errorMessage = ref('')
const resources = ref<SyncResource[]>([])

const labels: Record<string, string> = {
  corretores: 'Corretores',
  empreendimentos: 'Empreendimentos',
  leads: 'Leads / clientes',
  vendas: 'Vendas e comissões',
}

async function loadStatus() {
  const supabase = useSupabaseClient()

  const { data, error } = await supabase
    .from('integration_sync_state' as any)
    .select('resource,last_started_at,last_completed_at,last_success_at,last_error,records_processed')
    .eq('company_id', '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6')
    .eq('source', 'memude_core')
    .order('resource')

  if (error)
    throw error

  resources.value = (data ?? []) as unknown as SyncResource[]
}

async function synchronize() {
  loading.value = true
  message.value = ''
  errorMessage.value = ''
  try {
    const supabase = useSupabaseClient()
    const { data, error } = await supabase.functions.invoke('core-sync', { body: {} })
    if (error)
      throw error

    const result = data as { counts: Record<string, number> }

    message.value = `Sincronização concluída: ${Object.values(result.counts).reduce((total, value) => total + value, 0)} registros processados.`
    await loadStatus()
  }
  catch (error: any) {
    errorMessage.value = error?.data?.message || error?.message || 'Não foi possível sincronizar com o MeMude Core.'
  }
  finally {
    loading.value = false
  }
}

onMounted(async () => {
  try {
    await loadStatus()
  }
  catch (error: any) {
    errorMessage.value = error?.data?.message || 'Não foi possível consultar a integração.'
  }
})

useHead({ title: 'Integração Core' })
</script>

<template>
  <div>
    <AppPageHeader
      title="Integração com o MeMude Core"
      subtitle="Importação inicial, reconciliação e acompanhamento dos dados operacionais"
      icon="ri-loop-right-line"
    >
      <template #actions>
        <VBtn
          color="primary"
          prepend-icon="ri-refresh-line"
          :loading="loading"
          @click="synchronize"
        >
          Sincronizar agora
        </VBtn>
      </template>
    </AppPageHeader>

    <VAlert
      v-if="message"
      type="success"
      variant="tonal"
      class="mb-4"
      :text="message"
      closable
    />
    <VAlert
      v-if="errorMessage"
      type="error"
      variant="tonal"
      class="mb-4"
      :text="errorMessage"
      closable
    />

    <VAlert
      type="info"
      variant="tonal"
      class="mb-6"
      title="Fonte de verdade"
      text="Corretores, empreendimentos, leads e vendas originados no Core são atualizados pela integração. Registros financeiros e cadastros criados manualmente continuam preservados."
    />

    <VRow>
      <VCol
        v-for="item in resources"
        :key="item.resource"
        cols="12"
        md="6"
      >
        <VCard>
          <VCardItem>
            <template #prepend>
              <VAvatar
                color="primary"
                variant="tonal"
              >
                <VIcon icon="ri-database-2-line" />
              </VAvatar>
            </template>
            <VCardTitle>{{ labels[item.resource] ?? item.resource }}</VCardTitle>
            <VCardSubtitle>{{ item.records_processed }} registros na última execução</VCardSubtitle>
          </VCardItem>
          <VCardText>
            <div class="d-flex justify-space-between mb-2">
              <span class="text-medium-emphasis">Último sucesso</span>
              <span>{{ item.last_success_at ? new Date(item.last_success_at).toLocaleString('pt-BR') : 'Ainda não executada' }}</span>
            </div>
            <VAlert
              v-if="item.last_error"
              type="error"
              variant="tonal"
              density="compact"
              :text="item.last_error"
            />
            <VChip
              v-else
              color="success"
              size="small"
              variant="tonal"
            >
              Sem erros
            </VChip>
          </VCardText>
        </VCard>
      </VCol>
    </VRow>
  </div>
</template>
