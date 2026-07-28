import { useAppStore } from '@/stores/app'
import { useFinanceStore } from '@/stores/finance'
import { useAuditStore } from '@/stores/audit'

// ============================================================================
// Hidratação: ao ter um usuário autenticado (Supabase), carrega TODOS os dados
// das empresas dele e popula os stores. Roda no boot e reage a login/logout.
// ============================================================================
export default defineNuxtPlugin(async () => {
  const user = useSupabaseUser()
  const app = useAppStore()
  const finance = useFinanceStore()
  const audit = useAuditStore()

  async function hydrate() {
    app.setHydrationState(true)
    try {
      const data = await loadAppData()
      if (data) {
        app.hydrate(data)
        finance.hydrate(data.finance)
        if (data.currentUser.roles.length === 0 && useRoute().path !== '/sem-acesso')
          await navigateTo('/sem-acesso')
      }
      app.setHydrationState(false)
    }
    catch (e) {
      console.error('Falha ao carregar dados do Supabase:', e)
      app.setHydrationState(false, (e as Error).message || 'Não foi possível carregar os dados.')
    }
  }

  if (user.value)
    await hydrate()

  if (import.meta.client) {
    watch(user, async u => {
      if (u) {
        await hydrate()
      }
      else {
        app.reset()
        finance.reset()
        audit.reset()
      }
    })
  }
})
