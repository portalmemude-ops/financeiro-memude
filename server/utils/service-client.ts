import type { H3Event } from 'h3'
import type { SupabaseClient } from '@supabase/supabase-js'
import { createClient } from '@supabase/supabase-js'
// eslint-disable-next-line import/extensions
import { serverSupabaseServiceRole } from '#supabase/server'

// ============================================================================
// Cliente Supabase com chave secreta (ignora RLS).
//
// `serverSupabaseServiceRole` do @nuxtjs/supabase lança um erro seco quando não
// encontra a chave na variável de ambiente que ELE espera — o que virava um 500
// sem explicação nenhuma no anexo de comprovantes. Como o nome dessa variável
// mudou entre versões do módulo (service key vs. secret key), aqui aceitamos
// todos os nomes em uso e, se nenhum existir, devolvemos uma mensagem que diz o
// que fazer em vez de "erro 500".
// ============================================================================

const KEY_VARS = [
  'NUXT_SUPABASE_SERVICE_KEY',
  'SUPABASE_SERVICE_KEY',
  'NUXT_SUPABASE_SECRET_KEY',
  'SUPABASE_SECRET_KEY',
  'SUPABASE_SERVICE_ROLE_KEY',
] as const

const URL_VARS = [
  'NUXT_PUBLIC_SUPABASE_URL',
  'SUPABASE_URL',
] as const

let fallbackClient: SupabaseClient | null = null

function firstEnv(names: readonly string[]) {
  for (const name of names) {
    const value = process.env[name]
    if (value && value.trim() !== '')
      return value.trim()
  }

  return undefined
}

/** true quando alguma chave secreta está presente — usado no diagnóstico. */
export function hasServiceKey() {
  return Boolean(firstEnv(KEY_VARS))
}

export function serviceRoleClient(event: H3Event): SupabaseClient {
  try {
    return serverSupabaseServiceRole(event) as unknown as SupabaseClient
  }
  catch {
    // O módulo não achou a chave no nome que ele espera. Tentamos os outros.
  }

  if (fallbackClient)
    return fallbackClient

  const config = useRuntimeConfig()
  const url = firstEnv(URL_VARS) || (config.public as { supabase?: { url?: string } }).supabase?.url
  const key = firstEnv(KEY_VARS)

  if (!url || !key) {
    throw createError({
      statusCode: 500,
      message: 'A chave secreta do Supabase não está configurada no servidor. '
        + 'Defina NUXT_SUPABASE_SERVICE_KEY (a secret key do projeto) nas variáveis de ambiente da aplicação e reinicie.',
    })
  }

  fallbackClient = createClient(url, key, {
    auth: { persistSession: false, autoRefreshToken: false },
  })

  return fallbackClient
}
