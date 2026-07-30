import { getNfseConfig } from '../../utils/nfse/config'
import { isCertificateConfigured } from '../../utils/nfse/certificate'
import type { EmitirNfsePayload, EmitirNfseResult } from '../../utils/nfse/types'
import { emitirNfse } from '../../utils/nfse/ginfes/client'
import { emitirRequestSchema, parseBody } from '../../utils/nfse/schemas'
import { enforceRateLimit, requireAuthenticatedUser, requireCompanyRole } from '../../utils/security'

export default defineEventHandler(async (event): Promise<EmitirNfseResult> => {
  await requireAuthenticatedUser(event)

  const body = await parseBody(event, emitirRequestSchema)
  const { user, client, company } = await requireCompanyRole(event, body.companyId, ['super_admin', 'admin', 'financial'])
  const db = client as any

  enforceRateLimit(event, user.id, 5)

  const cfg = getNfseConfig()
  if (!cfg.enabled)
    throw createError({ statusCode: 503, message: 'Emissão fiscal desabilitada por segurança.' })
  if (!isCertificateConfigured())
    throw createError({ statusCode: 503, message: 'Certificado fiscal não configurado.' })
  if (cfg.provider === 'nacional')
    throw createError({ statusCode: 503, message: 'NFS-e Nacional ainda não habilitada.' })
  if (!company.cnpj || !company.municipal_registration)
    throw createError({ statusCode: 422, message: 'CNPJ ou inscrição municipal da empresa não configurados.' })

  const { data: persistedInvoice, error: invoiceError } = await db
    .from('invoices')
    .select('id, status')
    .eq('id', body.invoiceId)
    .eq('company_id', body.companyId)
    .single()

  if (invoiceError || !persistedInvoice)
    throw createError({ statusCode: 404, message: 'Nota fiscal persistida não encontrada.' })
  if (persistedInvoice.status === 'issued')
    throw createError({ statusCode: 409, message: 'A nota já foi emitida.' })

  const { data: rpsNumber, error: rpsError } = await db.rpc('next_rps_number', {
    target_company: body.companyId,
    target_environment: cfg.ambiente,
    target_series: body.invoice.rpsSeries,
  })

  if (rpsError)
    throw createError({ statusCode: 409, message: `Não foi possível reservar o RPS: ${rpsError.message}` })

  const invoice = body.invoice
  const municipio = invoice.municipioIbge || company.city_ibge || cfg.municipioIbge

  const payload: EmitirNfsePayload = {
    prestador: {
      cnpj: company.cnpj,
      inscricaoMunicipal: company.municipal_registration,
      razaoSocial: company.name,
      nomeFantasia: company.trade_name ?? undefined,
      cnaeCode: invoice.cnaeCode || company.main_cnae || undefined,
      optanteSimplesNacional: company.tax_regime === 'simples_nacional',
      cityIbge: company.city_ibge || cfg.municipioIbge,
    },
    tomador: {
      razaoSocial: invoice.taker.name,
      documento: invoice.taker.document,
      inscricaoMunicipal: invoice.taker.inscricaoMunicipal,
      email: invoice.taker.email,
      endereco: invoice.taker.address,
    },
    servico: {
      itemListaServico: invoice.lc116Item,
      codigoTributacaoMunicipio: invoice.ctiss,
      cnaeCode: invoice.cnaeCode || company.main_cnae || undefined,
      discriminacao: invoice.serviceDescription,
      valorServicos: invoice.amount,
      valorDeducoes: invoice.deductionsAmount,
      aliquota: invoice.issRate,
      issRetido: invoice.issRetido,
      codigoMunicipio: municipio,
      exigibilidadeIss: 1,
    },
    rps: {
      numero: String(rpsNumber),
      serie: invoice.rpsSeries,
      tipo: invoice.rpsType,
      dataEmissao: invoice.dataEmissao || new Date().toISOString(),
      competencia: invoice.competencia,
      naturezaOperacao: 1,
    },
  }

  try {
    await db.from('invoices').update({
      status: 'processing',
      rps_number: rpsNumber,
      rps_series: invoice.rpsSeries,
      environment: cfg.ambiente,
      updated_at: new Date().toISOString(),
    }).eq('id', body.invoiceId)

    const result = await emitirNfse(payload, cfg)

    await db.from('invoices').update({
      status: result.success ? 'issued' : 'error',
      nfse_number: result.invoiceNumber,
      verification_code: result.verificationCode,
      protocol: result.protocol,
      issued_at: result.issuedAt,
      xml_response: result.xmlBase64,
      error_message: result.errors?.map(error => error.message).join(' · ') || null,
      updated_at: new Date().toISOString(),
    }).eq('id', body.invoiceId)

    return result
  }
  catch (error) {
    await db.from('invoices').update({
      status: 'error',
      error_message: (error as Error).message,
      updated_at: new Date().toISOString(),
    }).eq('id', body.invoiceId)
    setResponseStatus(event, 502)

    return {
      success: false,
      status: 'error',
      errors: [{ code: 'FALHA_EMISSAO', message: (error as Error).message }],
      environment: cfg.ambiente,
    }
  }
})
