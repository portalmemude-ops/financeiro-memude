import { requireCompanyRole } from '../../../../utils/security'
import {
  ENTITY_TABLES,
  attachmentReference,
  decryptSecret,
  driveRequest,
  getStorageSettings,
  googleToken,
} from '../../../../utils/storage'
import { serviceRoleClient } from '../../../../utils/service-client'

// ============================================================================
// Exclui um anexo: apaga o arquivo do provedor, remove o registro e desfaz o
// vínculo com a conta. Boleto e comprovante são documento de respaldo fiscal,
// então a operação é restrita a administradores e fica registrada na auditoria.
// ============================================================================

export default defineEventHandler(async event => {
  const id = getRouterParam(event, 'id')
  const service = serviceRoleClient(event) as any

  const { data: attachment } = await service.from('attachments').select('*').eq('id', id).maybeSingle()
  if (!attachment)
    throw createError({ statusCode: 404, message: 'Anexo não encontrado.' })

  const { user } = await requireCompanyRole(event, attachment.company_id, ['super_admin', 'admin'])

  // 1) Remove o arquivo no provedor onde ele está guardado.
  if (attachment.provider === 'google_drive') {
    const { settings } = await getStorageSettings(event, attachment.company_id)
    if (!settings?.google_refresh_token_ciphertext)
      throw createError({ statusCode: 409, message: 'Reconecte o Google Drive para excluir este anexo.' })

    const token = await googleToken(decryptSecret(settings.google_refresh_token_ciphertext))

    try {
      await driveRequest(token, `https://www.googleapis.com/drive/v3/files/${encodeURIComponent(attachment.external_file_id)}`, { method: 'DELETE' })
    }
    catch (caught) {
      // Arquivo já removido à mão no Drive não deve travar a limpeza do registro.
      const message = caught instanceof Error ? caught.message : ''
      if (!message.includes('404'))
        throw createError({ statusCode: 502, message: `Não foi possível excluir o arquivo no Google Drive: ${message}` })
    }
  }
  else if (attachment.bucket_id && attachment.object_path) {
    const { error } = await service.storage.from(attachment.bucket_id).remove([attachment.object_path])
    if (error)
      throw createError({ statusCode: 500, message: `Não foi possível excluir o arquivo: ${error.message}` })
  }

  // 2) Desfaz o vínculo na conta, se ela ainda aponta para este anexo.
  const table = ENTITY_TABLES[attachment.entity_type as keyof typeof ENTITY_TABLES]
  if (table) {
    await service
      .from(table)
      .update({ proof_url: null })
      .eq('id', attachment.entity_id)
      .eq('company_id', attachment.company_id)
      .eq('proof_url', attachmentReference(attachment.id))
  }

  // 3) Remove o registro do anexo.
  const { error: deleteError } = await service.from('attachments').delete().eq('id', attachment.id)
  if (deleteError)
    throw createError({ statusCode: 500, message: `Não foi possível remover o registro do anexo: ${deleteError.message}` })

  await service.from('audit_log').insert({
    company_id: attachment.company_id,
    actor_id: user.id,
    action: 'delete',
    entity_type: 'attachment',
    entity_id: attachment.id,
    new_data: {
      summary: `Anexo excluído: ${attachment.original_name}`,
      originalName: attachment.original_name,
      provider: attachment.provider,
      linkedTo: `${attachment.entity_type}:${attachment.entity_id}`,
    },
  })

  return { deleted: true, id: attachment.id, entityType: attachment.entity_type, entityId: attachment.entity_id }
})
