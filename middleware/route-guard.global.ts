import { useAppStore } from '@/stores/app'

// ============================================================================
// Guarda de rota por empresa/perfil. Complementa a ocultação cosmética do menu:
// impede acesso por URL direta a páginas fora do escopo do perfil/empresa atual.
// A autorização efetiva também é aplicada por RLS e pelos endpoints server-side.
// ============================================================================

// páginas comerciais existem apenas para a imobiliária
const commercialRoutes = new Set([
  '/vendas',
  '/funil',
  '/empreendimentos',
  '/comissoes',
  '/portal-corretor',
])

// corretor só opera o próprio universo (portal, funil, vendas) — bloqueia gestão
const brokerBlocked = new Set([
  '/contas-a-pagar',
  '/contas-a-receber',
  '/fluxo-de-caixa',
  '/plano-de-contas',
  '/centros-de-custo',
  '/fornecedores',
  '/colaboradores',
  '/notas-fiscais',
  '/relatorios',
  '/configuracoes',
  '/importador',
  '/auditoria',
  '/dashboard-consolidado',
  '/empreendimentos',
  '/comissoes',
  '/integracao-core',
])

export default defineNuxtRouteMiddleware(to => {
  const app = useAppStore()
  const path = to.path

  // páginas comerciais indisponíveis para empresa do tipo agência
  if (commercialRoutes.has(path) && !app.isRealEstate)
    return navigateTo('/dashboard')

  // corretor não acessa páginas de gestão financeira/administrativa
  if (app.isBroker && brokerBlocked.has(path))
    return navigateTo('/portal-corretor')

  if (path === '/integracao-core' && !app.isSuperAdmin)
    return navigateTo('/dashboard')
})
