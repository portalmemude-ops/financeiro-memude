import { requireCompanyRole } from '../../../../utils/security'
import { decryptSecret, driveRequest, getStorageSettings, googleToken } from '../../../../utils/storage'
// eslint-disable-next-line import/extensions
import { serverSupabaseServiceRole } from '#supabase/server'

export default defineEventHandler(async event => {
  const id = getRouterParam(event, 'id')
  const service = serverSupabaseServiceRole(event) as any
  const { data: attachment } = await service.from('attachments').select('*').eq('id', id).maybeSingle()
  if (!attachment)
    throw createError({ statusCode: 404, message: 'Anexo não encontrado.' })
  await requireCompanyRole(event, attachment.company_id, ['super_admin', 'admin', 'financial', 'accountant', 'viewer'])

  if (attachment.provider === 'google_drive') {
    const { settings } = await getStorageSettings(event, attachment.company_id)
    if (!settings?.google_refresh_token_ciphertext)
      throw createError({ statusCode: 409, message: 'Reconecte o Google Drive para consultar este anexo.' })
    const token = await googleToken(decryptSecret(settings.google_refresh_token_ciphertext))
    const response = await driveRequest(token, `https://www.googleapis.com/drive/v3/files/${encodeURIComponent(attachment.external_file_id)}?alt=media`)

    setResponseHeader(event, 'Content-Type', attachment.mime_type || 'application/octet-stream')
    setResponseHeader(event, 'Content-Disposition', `inline; filename*=UTF-8''${encodeURIComponent(attachment.original_name)}`)

    return new Uint8Array(await response.arrayBuffer())
  }

  const { data, error } = await service.storage.from(attachment.bucket_id).createSignedUrl(attachment.object_path, 60)
  if (error || !data?.signedUrl)
    throw createError({ statusCode: 500, message: 'Não foi possível abrir o anexo.' })

  return sendRedirect(event, data.signedUrl)
})
