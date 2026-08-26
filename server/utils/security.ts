import type { H3Event } from 'h3'
import type { Database } from '@/types/database.types'
// eslint-disable-next-line import/extensions
import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'

export type CompanyRole = 'super_admin' | 'admin' | 'financial' | 'broker' | 'accountant' | 'viewer'

const rateLimitBuckets = new Map<string, { count: number; resetAt: number }>()

/**
 * Identidade do usuário logado, com o id sempre preenchido.
 *
 * Com as chaves novas do Supabase (publishable/secret + JWT assimétrico), o
 * `serverSupabaseUser` devolve os claims do token, onde o identificador vem em
 * `sub` e não em `id`. Ler `user.id` direto resultava em `undefined`, que ia
 * parar na consulta como `user_id=eq.undefined`: o PostgREST respondia 400 e o
 * app traduzia num 500 sem explicação — foi o que quebrou o envio de anexos.
 */
export async function requireAuthenticatedUser(event: H3Event) {
  const claims = await serverSupabaseUser(event) as unknown as (Record<string, unknown> & { id?: string; sub?: string }) | null
  const id = claims?.id || claims?.sub

  if (!claims || !id)
    throw createError({ statusCode: 401, statusMessage: 'Não autenticado', message: 'Faça login para continuar.' })

  return { ...claims, id }
}

export async function requireCompanyRole(event: H3Event, companyId: string, allowedRoles: CompanyRole[]) {
  const user = await requireAuthenticatedUser(event)
  const client = await serverSupabaseClient<Database>(event)

  const { data: membership, error: membershipError } = await client
    .from('company_members')
    .select('company_id, role')
    .eq('company_id', companyId)
    .eq('user_id', user.id)
    .maybeSingle()

  if (membershipError)
    throw createError({ statusCode: 500, message: `Não foi possível validar a autorização: ${membershipError.message}` })
  if (!membership || !allowedRoles.includes(membership.role as CompanyRole))
    throw createError({ statusCode: 403, statusMessage: 'Acesso negado', message: 'Seu perfil não permite esta operação.' })

  const { data: company, error: companyError } = await client
    .from('companies')
    .select('*')
    .eq('id', companyId)
    .single()

  if (companyError || !company)
    throw createError({ statusCode: 404, message: 'Empresa não encontrada.' })

  return { user, client, company, role: membership.role as CompanyRole }
}

/**
 * Contenção por processo Nitro. Para múltiplas réplicas, a evolução prevista é
 * mover o contador para Redis sem alterar o contrato dos endpoints.
 */
export function enforceRateLimit(event: H3Event, subject: string, limit: number, windowMs = 60_000) {
  const now = Date.now()
  const route = event.path.split('?')[0]
  const key = `${route}:${subject}`
  const current = rateLimitBuckets.get(key)

  if (!current || current.resetAt <= now) {
    rateLimitBuckets.set(key, { count: 1, resetAt: now + windowMs })

    return
  }

  if (current.count >= limit) {
    const retryAfter = Math.max(1, Math.ceil((current.resetAt - now) / 1000))

    setResponseHeader(event, 'Retry-After', retryAfter)
    throw createError({ statusCode: 429, statusMessage: 'Muitas requisições', message: 'Tente novamente em instantes.' })
  }

  current.count += 1
}
