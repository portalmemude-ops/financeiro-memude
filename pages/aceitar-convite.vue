<script setup lang="ts">
definePageMeta({ layout: 'blank' })
useHead({ title: 'Aceitar convite' })

const supabase = useSupabaseClient()
const user = useSupabaseUser()
const password = ref('')
const confirmation = ref('')
const loading = ref(false)
const error = ref('')

async function acceptInvite() {
  error.value = ''
  if (!user.value) {
    error.value = 'O convite não é válido ou expirou. Solicite um novo convite ao administrador.'

    return
  }
  if (password.value.length < 12) {
    error.value = 'Use uma senha com pelo menos 12 caracteres.'

    return
  }
  if (password.value !== confirmation.value) {
    error.value = 'As senhas não coincidem.'

    return
  }

  loading.value = true
  try {
    const { error: updateError } = await supabase.auth.updateUser({ password: password.value })
    if (updateError)
      throw updateError
    await navigateTo('/dashboard')
  }
  catch (caught) {
    error.value = (caught as Error).message
  }
  finally {
    loading.value = false
  }
}
</script>

<template>
  <div
    class="d-flex align-center justify-center pa-4"
    style="min-block-size: 100vh;"
  >
    <VCard
      max-width="480"
      width="100%"
      class="pa-6"
    >
      <VCardTitle class="text-h4">
        Ative seu acesso
      </VCardTitle>
      <VCardText>
        <VAlert
          v-if="error"
          type="error"
          variant="tonal"
          class="mb-4"
          :text="error"
        />
        <VForm @submit.prevent="acceptInvite">
          <VTextField
            v-model="password"
            type="password"
            label="Nova senha"
            autocomplete="new-password"
            hint="Mínimo de 12 caracteres"
            persistent-hint
            required
            minlength="12"
            class="mb-4"
          />
          <VTextField
            v-model="confirmation"
            type="password"
            label="Confirme a senha"
            autocomplete="new-password"
            required
            minlength="12"
            class="mb-4"
          />
          <VBtn
            block
            type="submit"
            :loading="loading"
          >
            Ativar acesso
          </VBtn>
        </VForm>
      </VCardText>
    </VCard>
  </div>
</template>
