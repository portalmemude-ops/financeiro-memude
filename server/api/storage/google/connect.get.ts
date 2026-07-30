import { randomBytes } from 'node:crypto'
import { requireCompanyRole } from '../../../utils/security'
import { googleConfig, sha256 } from '../../../utils/storage'
// eslint-disable-next-line import/extensions
import { serverSupabaseServiceRole } from '#supabase/server'

export default defineEventHandler(async event => {
  const companyId = getQuery(event).companyId?.toString()
  if (!companyId)
    throw createError({ statusCode: 400, message: 'Empresa não informada.' })
  const { user } = await requireCompanyRole(event, companyId, ['super_admin', 'admin'])
  const service = serverSupabaseServiceRole(event) as any
  const state = randomBytes(32).toString('base64url')

  const { error } = await service.from('storage_oauth_states').insert({
    state_hash: sha256(state),
    company_id: companyId,
    user_id: user.id,
    expires_at: new Date(Date.now() + 10 * 60_000).toISOString(),
  })

  if (error)
    throw createError({ statusCode: 500, message: 'Não foi possível iniciar a conexão segura.' })
  const config = googleConfig(event)

  const params = new URLSearchParams({
    client_id: config.clientId,
    redirect_uri: config.redirectUri,
    response_type: 'code',
    scope: 'https://www.googleapis.com/auth/drive.file',
    access_type: 'offline',
    prompt: 'consent',
    include_granted_scopes: 'true',
    state,
  })

  return sendRedirect(event, `https://accounts.google.com/o/oauth2/v2/auth?${params}`)
})
