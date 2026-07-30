// ============================================================================
// Proteção de rota: usuários não autenticados só acessam login/register.
// O estado de autenticação vem da sessão do Supabase (useSupabaseUser),
// restaurada do cookie tanto no SSR quanto no cliente.
// ============================================================================

const publicPages = new Set(['/login', '/register', '/aceitar-convite'])

export default defineNuxtRouteMiddleware(to => {
  const user = useSupabaseUser()

  if (!user.value && !publicPages.has(to.path))
    return navigateTo('/login')

  if (user.value && publicPages.has(to.path) && to.path !== '/aceitar-convite')
    return navigateTo('/dashboard')
})
