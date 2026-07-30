// Endpoint público de health check (Dokploy/Docker monitoram o container por aqui).
// Rotas de API do Nitro não passam pelo middleware de rota do Vue, então este
// endpoint responde sem exigir autenticação.
export default defineEventHandler(() => ({
  status: 'ok',
  service: 'memude-financeiro',
  timestamp: new Date().toISOString(),
}))
