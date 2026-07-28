import { getNfseConfig } from '../../utils/nfse/config'
import { isCertificateConfigured } from '../../utils/nfse/certificate'
import type { ConsultarNfsePayload, EmitirNfseResult } from '../../utils/nfse/types'
import { consultarPorRps } from '../../utils/nfse/ginfes/client'
import { consultarRequestSchema, parseBody } from '../../utils/nfse/schemas'
import { enforceRateLimit, requireAuthenticatedUser, requireCompanyRole } from '../../utils/security'

export default defineEventHandler(async (event): Promise<EmitirNfseResult> => {
  await requireAuthenticatedUser(event)

  const body = await parseBody(event, consultarRequestSchema)
  const { user, company } = await requireCompanyRole(event, body.companyId, ['super_admin', 'admin', 'financial'])

  enforceRateLimit(event, user.id, 15)

  const cfg = getNfseConfig()
  if (!cfg.enabled || !isCertificateConfigured())
    throw createError({ statusCode: 503, message: 'Consulta fiscal não configurada.' })
  if (cfg.provider === 'nacional')
    throw createError({ statusCode: 503, message: 'Consulta pela NFS-e Nacional ainda não habilitada.' })
  if (!company.cnpj)
    throw createError({ statusCode: 422, message: 'CNPJ da empresa não configurado.' })

  const payload: ConsultarNfsePayload = {
    prestador: {
      cnpj: company.cnpj,
      inscricaoMunicipal: company.municipal_registration ?? undefined,
      cityIbge: company.city_ibge || cfg.municipioIbge,
    },
    rpsNumero: body.rpsNumber,
    rpsSerie: body.rpsSeries,
    rpsTipo: body.rpsType,
  }

  try {
    return await consultarPorRps(payload, cfg)
  }
  catch (error) {
    setResponseStatus(event, 502)

    return {
      success: false,
      status: 'error',
      errors: [{ code: 'FALHA_CONSULTA', message: (error as Error).message }],
      environment: cfg.ambiente,
    }
  }
})
