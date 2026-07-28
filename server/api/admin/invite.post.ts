import { z } from 'zod'
import { parseBody } from '../../utils/nfse/schemas'
import { enforceRateLimit, requireAuthenticatedUser, requireCompanyRole } from '../../utils/security'
// eslint-disable-next-line import/extensions
import { serverSupabaseServiceRole } from '#supabase/server'

const inviteSchema = z.object({
  companyId: z.uuid(),
  email: z.email().max(254),
  fullName: z.string().trim().min(2).max(150),
  role: z.enum(['admin', 'financial', 'broker', 'accountant', 'viewer']),
}).strict()

export default defineEventHandler(async event => {
  await requireAuthenticatedUser(event)

  const body = await parseBody(event, inviteSchema)
  const { user, role } = await requireCompanyRole(event, body.companyId, ['super_admin', 'admin'])

  enforceRateLimit(event, user.id, 10, 60 * 60 * 1000)

  if (role === 'admin' && body.role === 'admin')
    throw createError({ statusCode: 403, message: 'Somente superadministradores podem convidar outro administrador.' })

  const serviceRole = serverSupabaseServiceRole(event)
  const redirectTo = `${getRequestURL(event).origin}/aceitar-convite`

  const { data, error } = await serviceRole.auth.admin.inviteUserByEmail(body.email.trim().toLowerCase(), {
    data: { full_name: body.fullName },
    redirectTo,
  })

  if (error)
    throw createError({ statusCode: 422, message: error.message })
  if (!data.user)
    throw createError({ statusCode: 500, message: 'O provedor não retornou o usuário convidado.' })

  const { error: membershipError } = await serviceRole.from('company_members').upsert({
    user_id: data.user.id,
    company_id: body.companyId,
    role: body.role,
  })

  if (membershipError) {
    await serviceRole.auth.admin.deleteUser(data.user.id)
    throw createError({ statusCode: 500, message: `Convite criado, mas o vínculo falhou: ${membershipError.message}` })
  }

  return { invited: true, userId: data.user.id }
})
