import { createHash, randomUUID } from 'node:crypto'
import { PORTAL_MEMUDE_COMPANY_ID, syncCore, verifyCoreWebhook } from '../../../utils/core-integration'
// eslint-disable-next-line import/extensions
import { serverSupabaseServiceRole } from '#supabase/server'

export default defineEventHandler(async event => {
  const rawBody = await readRawBody(event, 'utf8')
  if (!rawBody || !verifyCoreWebhook(event, rawBody))
    throw createError({ statusCode: 401, message: 'Assinatura do webhook inválida ou expirada.' })

  const payload = JSON.parse(rawBody) as Record<string, unknown>
  const eventId = typeof payload.event_id === 'string' ? payload.event_id : randomUUID()
  const entityType = typeof payload.entity_type === 'string' ? payload.entity_type : 'unknown'
  const entityId = typeof payload.entity_id === 'string' ? payload.entity_id : null
  const finance = serverSupabaseServiceRole(event)

  const { error } = await finance.from('integration_events').insert({
    company_id: PORTAL_MEMUDE_COMPANY_ID,
    event_id: eventId,
    source: 'memude_core',
    event_type: typeof payload.event_type === 'string' ? payload.event_type : 'changed',
    entity_type: entityType,
    entity_id: entityId,
    occurred_at: typeof payload.occurred_at === 'string' ? payload.occurred_at : new Date().toISOString(),
    payload,
    payload_hash: createHash('sha256').update(rawBody).digest('hex'),
    status: 'processing',
    attempts: 1,
  })

  if (error?.code === '23505')
    return { accepted: true, duplicate: true }
  if (error)
    throw createError({ statusCode: 500, message: 'Não foi possível registrar o evento.' })

  try {
    const result = await syncCore(event)

    await finance.from('integration_events').update({ status: 'processed', processed_at: new Date().toISOString() }).eq('event_id', eventId)

    return { accepted: true, result }
  }
  catch (failure) {
    const message = failure instanceof Error ? failure.message : 'Falha ao processar evento.'

    await finance.from('integration_events').update({ status: 'failed', last_error: message }).eq('event_id', eventId)
    throw failure
  }
})
