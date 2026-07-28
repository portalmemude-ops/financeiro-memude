<script setup lang="ts">
import { useAppStore } from '@/stores/app'

const app = useAppStore()

async function retryHydration() {
  app.setHydrationState(true)
  try {
    const data = await loadAppData()
    if (data) {
      app.hydrate(data)
      useFinanceStore().hydrate(data.finance)
    }
    app.setHydrationState(false)
  }
  catch (error) {
    app.setHydrationState(false, (error as Error).message)
  }
}
</script>

<template>
  <VApp>
    <VProgressLinear
      v-if="app.isHydrating"
      indeterminate
      color="primary"
      style="position: fixed; z-index: 9999; inset-block-start: 0;"
    />
    <VAlert
      v-if="app.dataError"
      type="error"
      variant="elevated"
      closable
      class="ma-4"
      style="position: fixed; z-index: 9998; inset-inline: 0;"
      title="Falha ao carregar os dados"
      :text="app.dataError"
      @click:close="app.dataError = ''"
    >
      <template #append>
        <VBtn
          variant="text"
          @click="retryHydration"
        >
          Tentar novamente
        </VBtn>
      </template>
    </VAlert>
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </VApp>
</template>
