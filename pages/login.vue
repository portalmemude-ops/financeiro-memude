<script setup lang="ts">
import { useTheme } from 'vuetify'
import { useAuthStore } from '@/stores/auth'
import brand from '@images/brand-full.svg?raw'
import authV1MaskDark from '@images/pages/auth-v1-mask-dark.png'
import authV1MaskLight from '@images/pages/auth-v1-mask-light.png'
import authV1Tree2 from '@images/pages/auth-v1-tree-2.png'
import authV1Tree from '@images/pages/auth-v1-tree.png'

const auth = useAuthStore()

const form = ref({
  email: '',
  password: '',
  remember: false,
})

const error = ref<string | null>(null)
const loading = ref(false)

async function onSubmit() {
  error.value = null
  loading.value = true
  try {
    await auth.login(form.value.email, form.value.password)
    await navigateTo('/dashboard', { external: true })
  }
  catch (e) {
    error.value = (e as Error).message === 'Invalid login credentials'
      ? 'E-mail ou senha inválidos.'
      : (e as Error).message || 'Não foi possível entrar.'
  }
  finally {
    loading.value = false
  }
}

const vuetifyTheme = useTheme()

const authThemeMask = computed(() => {
  return vuetifyTheme.global.name.value === 'light'
    ? authV1MaskLight
    : authV1MaskDark
})

const isPasswordVisible = ref(false)

definePageMeta({ layout: 'blank' })
</script>

<template>
  <!-- eslint-disable vue/no-v-html -->

  <div class="auth-wrapper d-flex align-center justify-center pa-4">
    <VCard
      class="auth-card pa-4 pt-7"
      max-width="448"
    >
      <VCardItem class="justify-center">
        <NuxtLink
          to="/"
          class="d-flex align-center gap-3"
        >
          <!-- eslint-disable vue/no-v-html -->
          <div
            class="d-flex auth-brand"
            v-html="brand"
          />
        </NuxtLink>
      </VCardItem>

      <VCardText class="pt-2">
        <h4 class="text-h4 mb-1">
          Bem-vindo ao MeMude Financeiro! 👋
        </h4>
        <p class="mb-0">
          Acesse sua conta para gerenciar as finanças do Portal MeMude
        </p>
      </VCardText>

      <VCardText>
        <VForm @submit.prevent="onSubmit">
          <VRow>
            <VCol
              v-if="error"
              cols="12"
              class="pb-0"
            >
              <VAlert
                type="error"
                variant="tonal"
                density="compact"
                :text="error"
              />
            </VCol>
            <!-- email -->
            <VCol cols="12">
              <VTextField
                :id="useId()"
                v-model="form.email"
                label="E-mail"
                type="email"
                placeholder="portalmemude@gmail.com"
              />
            </VCol>

            <!-- senha -->
            <VCol cols="12">
              <VTextField
                :id="useId()"
                v-model="form.password"
                label="Senha"
                placeholder="············"
                :type="isPasswordVisible ? 'text' : 'password'"
                autocomplete="current-password"
                :append-inner-icon="isPasswordVisible ? 'ri-eye-off-line' : 'ri-eye-line'"
                @click:append-inner="isPasswordVisible = !isPasswordVisible"
              />

              <!-- lembrar -->
              <div class="d-flex align-center justify-space-between flex-wrap my-6">
                <VCheckbox
                  :id="useId()"
                  v-model="form.remember"
                  label="Lembrar de mim"
                />

                <span
                  class="text-primary text-disabled"
                  style="cursor: default;"
                >
                  Esqueceu a senha?
                </span>
              </div>

              <!-- botão entrar -->
              <VBtn
                block
                type="submit"
                :loading="loading"
              >
                Entrar
              </VBtn>
            </VCol>

            <!-- criar conta -->
            <VCol
              cols="12"
              class="text-center text-base"
            >
              <span>Precisa de acesso?</span>
              <NuxtLink
                class="text-primary ms-2"
                to="/register"
              >
                Entenda como receber um convite
              </NuxtLink>
            </VCol>
          </VRow>
        </VForm>
      </VCardText>
    </VCard>

    <VImg
      class="auth-footer-start-tree d-none d-md-block"
      :src="authV1Tree"
      :width="250"
    />

    <VImg
      :src="authV1Tree2"
      class="auth-footer-end-tree d-none d-md-block"
      :width="350"
    />

    <!-- bg img -->
    <VImg
      class="auth-footer-mask d-none d-md-block"
      :src="authThemeMask"
    />
  </div>
</template>

<style lang="scss">
@use "@core/scss/template/pages/page-auth";

.auth-brand {
  inline-size: min(100%, 310px);

  svg {
    display: block;
    inline-size: 100%;
  }
}
</style>
