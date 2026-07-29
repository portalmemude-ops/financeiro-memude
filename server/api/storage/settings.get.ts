import { requireCompanyRole } from '../../utils/security'
import { getStorageSettings } from '../../utils/storage'

export default defineEventHandler(async event => {
  const companyId = getQuery(event).companyId?.toString()
  if (!companyId)
    throw createError({ statusCode: 400, message: 'Empresa não informada.' })
  await requireCompanyRole(event, companyId, ['super_admin', 'admin', 'financial', 'broker', 'accountant', 'viewer'])

  const { settings } = await getStorageSettings(event, companyId)

  return {
    activeProvider: settings?.active_provider || 'internal',
    googleConnected: Boolean(settings?.google_refresh_token_ciphertext),
    googleConfigured: Boolean(process.env.GOOGLE_DRIVE_CLIENT_ID && process.env.GOOGLE_DRIVE_CLIENT_SECRET && process.env.GOOGLE_DRIVE_TOKEN_ENCRYPTION_KEY),
    googleAccountEmail: settings?.google_account_email || null,
    connectedAt: settings?.connected_at || null,
  }
})
