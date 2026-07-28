<script setup lang="ts">
definePageMeta({ layout: 'blank' })
useHead({ title: 'Acesso por convite' })
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
        Acesso protegido por convite
      </VCardTitle>
      <VCardText class="pt-4">
        <VAlert
          type="info"
          variant="tonal"
          class="mb-6"
          text="Para proteger os dados financeiros das empresas, novos usuários são cadastrados somente por um administrador."
        />
        Solicite ao administrador da sua empresa um convite para o seu e-mail. O link recebido permitirá definir sua senha e ativará apenas o perfil autorizado.
      </VCardText>
      <VCardActions>
        <VBtn
          to="/login"
          block
          color="primary"
        >
          Voltar para o login
        </VBtn>
      </VCardActions>
    </VCard>
  </div>
</template>
