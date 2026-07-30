import { getNfseConfig } from '../../utils/nfse/config'
import { isCertificateConfigured } from '../../utils/nfse/certificate'
import type { CancelarNfsePayload, CancelarNfseResult } from '../../utils/nfse/types'
import { cancelarNfse } from '../../utils/nfse/ginfes/client'
import { cancelarRequestSchema, parseBody } from '../../utils/nfse/schemas'
import { enforceRateLimit, requireAuthenticatedUser, requireCompanyRole } from '../../utils/security'

export default defineEventHandler(async (event): Promise<CancelarNfseResult> => {
  await requireAuthenticatedUser(event)

  const body = await parseBody(event, cancelarRequestSchema)
  const { user, client, company } = await requireCompanyRole(event, body.companyId, ['super_admin', 'admin', 'financial'])
  const db = client as any

  enforceRateLimit(event, user.id, 3)

  const cfg = getNfseConfig()
  if (!cfg.enabled || !isCertificateConfigured())
    throw createError({ statusCode: 503, message: 'Cancelamento fiscal não configurado.' })
  if (cfg.provider === 'nacional')
    throw createError({ statusCode: 503, message: 'Cancelamento pela NFS-e Nacional ainda não habilitado.' })
  if (!company.cnpj)
    throw createError({ statusCode: 422, message: 'CNPJ da empresa não configurado.' })

  const payload: CancelarNfsePayload = {
    prestador: {
      cnpj: company.cnpj,
      inscricaoMunicipal: company.municipal_registration ?? undefined,
      cityIbge: company.city_ibge || cfg.municipioIbge,
    },
    numeroNfse: body.numeroNfse,
    codigoMunicipio: body.codigoMunicipio || company.city_ibge || cfg.municipioIbge,
    codigoCancelamento: body.codigoCancelamento,
    motivo: body.motivo,
  }

  try {
    const result = await cancelarNfse(payload, cfg)
    if (result.success) {
      await db.from('invoices').update({
        status: 'cancelled',
        cancelled_at: result.cancelledAt ?? new Date().toISOString(),
        updated_at: new Date().toISOString(),
      }).eq('id', body.invoiceId).eq('company_id', body.companyId)
    }

    return result
  }
  catch (error) {
    setResponseStatus(event, 502)

    return { success: false, errors: [{ code: 'FALHA_CANCELAMENTO', message: (error as Error).message }] }
  }
})
