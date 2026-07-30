import { getNfseConfig } from '../../utils/nfse/config'
import { isCertificateConfigured, loadCertificate } from '../../utils/nfse/certificate'
import { enforceRateLimit, requireAuthenticatedUser } from '../../utils/security'

export default defineEventHandler(async event => {
  const user = await requireAuthenticatedUser(event)

  enforceRateLimit(event, user.id, 30)

  const cfg = getNfseConfig()
  const hasCert = isCertificateConfigured()
  let certificate: { present: boolean; notAfter?: string; daysToExpire?: number } = { present: false }

  if (hasCert) {
    try {
      const loaded = loadCertificate()

      certificate = {
        present: true,
        notAfter: loaded.notAfter,
        daysToExpire: Math.floor((new Date(loaded.notAfter).getTime() - Date.now()) / 86_400_000),
      }
    }
    catch {
      // Não expõe CN, documento do titular, senha, caminho ou erro do parser.
      certificate = { present: true }
    }
  }

  return {
    enabled: cfg.enabled,
    configured: cfg.enabled && hasCert && Boolean(certificate.notAfter),
    provider: cfg.provider,
    ambiente: cfg.ambiente,
    municipioIbge: cfg.municipioIbge,
    certificate,
  }
})
