import { readBody } from 'h3'
import { requireCompanyRole } from '../../utils/security'
import { getStorageSettings } from '../../utils/storage'

export default defineEventHandler(async event => {
  const body = await readBody<{ companyId?: string; activeProvider?: string }>(event)
  if (!body.companyId || !['internal', 'google_drive'].includes(body.activeProvider || ''))
    throw createError({ statusCode: 400, message: 'Configuração inválida.' })
  await requireCompanyRole(event, body.companyId, ['super_admin', 'admin'])

  const { service, settings } = await getStorageSettings(event, body.companyId)
  if (body.activeProvider === 'google_drive' && !settings?.google_refresh_token_ciphertext)
    throw createError({ statusCode: 409, message: 'Conecte uma conta Google Drive antes de ativá-la.' })

  const { error } = await service.from('company_storage_settings').upsert({
    company_id: body.companyId,
    active_provider: body.activeProvider,
    updated_at: new Date().toISOString(),
  })

  if (error)
    throw createError({ statusCode: 500, message: 'Não foi possível alterar o armazenamento.' })

  return { ok: true }
})
