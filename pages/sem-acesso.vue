<script setup lang="ts">
import { useAuthStore } from '@/stores/auth'

definePageMeta({ layout: 'blank' })
useHead({ title: 'Acesso pendente' })

const auth = useAuthStore()
</script>

<template>
  <div
    class="d-flex align-center justify-center pa-4"
    style="min-block-size: 100vh;"
  >
    <VCard
      max-width="520"
      class="pa-6"
    >
      <VCardTitle class="text-h4 text-wrap">
        Seu usuário ainda não possui uma empresa
      </VCardTitle>
      <VCardText class="pt-4">
        Peça ao administrador para reenviar o convite ou confirmar seu vínculo e perfil de acesso.
      </VCardText>
      <VCardActions>
        <VBtn
          block
          color="primary"
          @click="auth.logout"
        >
          Sair
        </VBtn>
      </VCardActions>
    </VCard>
  </div>
</template>
