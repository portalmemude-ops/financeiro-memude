import { requireAuthenticatedUser } from '../../../utils/security'
import { driveRequest, encryptSecret, findOrCreateDriveFolder, googleConfig, sha256 } from '../../../utils/storage'
// eslint-disable-next-line import/extensions
import { serverSupabaseServiceRole } from '#supabase/server'

export default defineEventHandler(async event => {
  const query = getQuery(event)
  const state = query.state?.toString()
  const code = query.code?.toString()
  const fail = (message: string) => sendRedirect(event, `/configuracoes?tab=storage&storageError=${encodeURIComponent(message)}`)
  if (query.error)
    return fail('A autorização do Google Drive foi cancelada.')
  if (!state || !code)
    return fail('Resposta de autorização incompleta.')

  const user = await requireAuthenticatedUser(event)
  const service = serverSupabaseServiceRole(event) as any

  const { data: oauthState } = await service.from('storage_oauth_states')
    .delete().eq('state_hash', sha256(state)).select('*').maybeSingle()

  if (!oauthState || oauthState.user_id !== user.id || new Date(oauthState.expires_at).getTime() < Date.now())
    return fail('A conexão expirou ou já foi utilizada. Tente novamente.')

  try {
    const config = googleConfig(event)

    const tokenResponse = await fetch('https://oauth2.googleapis.com/token', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({
        client_id: config.clientId,
        client_secret: config.clientSecret,
        code,
        grant_type: 'authorization_code',
        redirect_uri: config.redirectUri,
      }),
    })

    const token = await tokenResponse.json() as { access_token?: string; refresh_token?: string; scope?: string; error_description?: string }
    if (!tokenResponse.ok || !token.access_token || !token.refresh_token)
      throw new Error(token.error_description || 'O Google não forneceu uma credencial offline.')

    const aboutResponse = await driveRequest<{ user: { emailAddress: string } }>(
      token.access_token,
      'https://www.googleapis.com/drive/v3/about?fields=user(emailAddress)',
    )

    const about = await aboutResponse.json()
    const rootFolderId = await findOrCreateDriveFolder(token.access_token, 'MeMude Financeiro')

    const { error } = await service.from('company_storage_settings').upsert({
      company_id: oauthState.company_id,
      active_provider: 'google_drive',
      google_account_email: about.user.emailAddress,
      google_root_folder_id: rootFolderId,
      google_refresh_token_ciphertext: encryptSecret(token.refresh_token),
      google_scopes: (token.scope || '').split(' ').filter(Boolean),
      connected_by: user.id,
      connected_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    })

    if (error)
      throw error

    return sendRedirect(event, '/configuracoes?tab=storage&storage=connected')
  }
  catch (error) {
    return fail(error instanceof Error ? error.message : 'Não foi possível concluir a conexão.')
  }
})
