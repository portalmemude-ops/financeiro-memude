import { readBody } from 'h3'
import { requireCompanyRole } from '../../../utils/security'
import { decryptSecret, getStorageSettings, googleToken } from '../../../utils/storage'

export default defineEventHandler(async event => {
  const { companyId } = await readBody<{ companyId?: string }>(event)
  if (!companyId)
    throw createError({ statusCode: 400, message: 'Empresa não informada.' })
  await requireCompanyRole(event, companyId, ['super_admin', 'admin'])

  const { service, settings } = await getStorageSettings(event, companyId)

  const { count } = await service.from('attachments')
    .select('id', { count: 'exact', head: true })
    .eq('company_id', companyId)
    .eq('provider', 'google_drive')

  if ((count || 0) > 0) {
    throw createError({
      statusCode: 409,
      message: `Existem ${count} anexo(s) hospedado(s) no Google Drive. Ative o armazenamento interno sem desconectar para preservar o acesso.`,
    })
  }

  if (settings?.google_refresh_token_ciphertext) {
    try {
      const refreshToken = decryptSecret(settings.google_refresh_token_ciphertext)
      const accessToken = await googleToken(refreshToken)

      await fetch(`https://oauth2.googleapis.com/revoke?token=${encodeURIComponent(accessToken)}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      })
    }
    catch {
      // Local revocation must remain possible even when Google is unavailable.
    }
  }

  const { error } = await service.from('company_storage_settings').upsert({
    company_id: companyId,
    active_provider: 'internal',
    google_account_email: null,
    google_root_folder_id: null,
    google_refresh_token_ciphertext: null,
    google_scopes: [],
    connected_by: null,
    connected_at: null,
    updated_at: new Date().toISOString(),
  })

  if (error)
    throw createError({ statusCode: 500, message: 'Não foi possível desconectar o Google Drive.' })

  return { ok: true }
})
