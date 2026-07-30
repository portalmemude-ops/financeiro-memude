import { enforceRateLimit } from '../../../utils/security'
import { authorizeCoreSync, syncCore } from '../../../utils/core-integration'

export default defineEventHandler(async event => {
  await authorizeCoreSync(event)
  enforceRateLimit(event, 'core-sync', 6, 60 * 60 * 1000)

  return await syncCore(event)
})
