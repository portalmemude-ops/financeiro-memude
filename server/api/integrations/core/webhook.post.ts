import { createHash, randomUUID } from 'node:crypto'
import { PORTAL_MEMUDE_COMPANY_ID, syncCore, verifyCoreWebhook } from '../../../utils/core-integration'
import { serviceRoleClient } from '../../../utils/service-client'

export default defineEventHandler(async event => {
  const rawBody = await readRawBody(event, 'utf8')
  if (!rawBody || !verifyCoreWebhook(event, rawBody))
    throw createError({ statusCode: 401, message: 'Assinatura do webhook inválida ou expirada.' })

  const payload = JSON.parse(rawBody) as Record<string, unknown>
  const eventId = typeof payload.event_id === 'string' ? payload.event_id : randomUUID()
  const entityType = typeof payload.entity_type === 'string' ? payload.entity_type : 'unknown'
  const entityId = typeof payload.entity_id === 'string' ? payload.entity_id : null
  const finance = serviceRoleClient(event)

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

  if (error?.code === '23505') {
    const { data: existing } = await finance
      .from('integration_events')
      .select('status,attempts')
      .eq('source', 'memude_core')
      .eq('event_id', eventId)
      .maybeSingle()

    if (existing?.status === 'processed' || existing?.status === 'ignored')
      return { accepted: true, duplicate: true }

    const { error: retryError } = await finance
      .from('integration_events')
      .update({
        status: 'processing',
        attempts: Number(existing?.attempts ?? 0) + 1,
        last_error: null,
        updated_at: new Date().toISOString(),
      })
      .eq('source', 'memude_core')
      .eq('event_id', eventId)

    if (retryError)
      throw createError({ statusCode: 500, message: 'Não foi possível reprocessar o evento.' })
  }
  if (error && error.code !== '23505')
    throw createError({ statusCode: 500, message: 'Não foi possível registrar o evento.' })

  try {
    let result: unknown
    if (payload.event_type === 'vendas.delete.requested.v1' && entityType === 'vendas' && entityId) {
      const deletionRequestId = typeof payload.deletion_request_id === 'string'
        ? payload.deletion_request_id
        : eventId

      const { data, error: deleteError } = await (finance as any).rpc('delete_core_sale_mirror', {
        _core_venda_id: entityId,
        _request_id: deletionRequestId,
      })

      if (deleteError)
        throw createError({ statusCode: 409, message: deleteError.message })
      result = data
    }
    else {
      result = await syncCore(event)
    }

    await finance.from('integration_events').update({
      status: 'processed',
      processed_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    }).eq('source', 'memude_core').eq('event_id', eventId)

    return { accepted: true, result }
  }
  catch (failure) {
    const message = failure instanceof Error ? failure.message : 'Falha ao processar evento.'

    await finance.from('integration_events').update({
      status: 'failed',
      last_error: message,
      next_retry_at: new Date(Date.now() + 5 * 60 * 1000).toISOString(),
      updated_at: new Date().toISOString(),
    }).eq('source', 'memude_core').eq('event_id', eventId)
    throw failure
  }
})
