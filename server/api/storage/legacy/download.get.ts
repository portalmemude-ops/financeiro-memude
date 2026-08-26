import { requireCompanyRole } from '../../../utils/security'
import { ATTACHMENT_BUCKET } from '../../../utils/storage'
import { serviceRoleClient } from '../../../utils/service-client'

export default defineEventHandler(async event => {
  const query = getQuery(event)
  const companyId = query.companyId?.toString()
  const path = query.path?.toString()
  if (!companyId || !path || !path.startsWith(`${companyId}/`) || path.includes('..'))
    throw createError({ statusCode: 400, message: 'Referência de anexo inválida.' })
  await requireCompanyRole(event, companyId, ['super_admin', 'admin', 'financial', 'accountant', 'viewer'])

  const service = serviceRoleClient(event)
  const { data, error } = await service.storage.from(ATTACHMENT_BUCKET).createSignedUrl(path, 60)
  if (error || !data?.signedUrl)
    throw createError({ statusCode: 404, message: 'Anexo legado não encontrado.' })

  return sendRedirect(event, data.signedUrl)
})
