import type { SupabaseClient } from '@supabase/supabase-js'
import { PORTAL_MEMUDE_COMPANY_ID } from '../../../utils/core-integration'
import { requireCompanyRole } from '../../../utils/security'

export default defineEventHandler(async event => {
  const { client } = await requireCompanyRole(event, PORTAL_MEMUDE_COMPANY_ID, ['super_admin', 'admin'])
  const integrationClient = client as unknown as SupabaseClient

  const { data, error } = await integrationClient
    .from('integration_sync_state')
    .select('resource,last_started_at,last_completed_at,last_success_at,last_error,records_processed')
    .eq('company_id', PORTAL_MEMUDE_COMPANY_ID)
    .eq('source', 'memude_core')
    .order('resource')

  if (error)
    throw createError({ statusCode: 500, message: 'Não foi possível consultar o estado da integração.' })

  return { resources: data ?? [] }
})
