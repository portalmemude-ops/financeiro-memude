import { createCipheriv, createDecipheriv, createHash, randomBytes } from 'node:crypto'
import { Buffer } from 'node:buffer'
import type { H3Event } from 'h3'
// eslint-disable-next-line import/extensions
import { serverSupabaseServiceRole } from '#supabase/server'

export const ATTACHMENT_BUCKET = 'financial-attachments'
export const MAX_ATTACHMENT_BYTES = 10 * 1024 * 1024
export const ALLOWED_ATTACHMENT_TYPES = new Set(['image/png', 'image/jpeg', 'application/pdf'])
export const ENTITY_TABLES = {
  payable: 'payables',
  receivable: 'receivables',
  invoice: 'invoices',
  supplier: 'suppliers',
  employee: 'employees',
} as const

export function attachmentReference(id: string) {
  return `/api/storage/attachments/${id}/download`
}

export function sha256(value: string | Uint8Array) {
  return createHash('sha256').update(value).digest('hex')
}

function encryptionKey() {
  const raw = process.env.GOOGLE_DRIVE_TOKEN_ENCRYPTION_KEY
  if (!raw)
    throw createError({ statusCode: 503, message: 'A criptografia da integração Google Drive não foi configurada.' })
  const key = Buffer.from(raw, 'base64')
  if (key.length !== 32)
    throw createError({ statusCode: 503, message: 'GOOGLE_DRIVE_TOKEN_ENCRYPTION_KEY deve ter 32 bytes em Base64.' })

  return key
}

export function encryptSecret(value: string) {
  const iv = randomBytes(12)
  const cipher = createCipheriv('aes-256-gcm', encryptionKey(), iv)
  const encrypted = Buffer.concat([cipher.update(value, 'utf8'), cipher.final()])

  return `v1:${iv.toString('base64url')}:${cipher.getAuthTag().toString('base64url')}:${encrypted.toString('base64url')}`
}

export function decryptSecret(value: string) {
  const [version, iv, tag, encrypted] = value.split(':')
  if (version !== 'v1' || !iv || !tag || !encrypted)
    throw new Error('Credencial criptografada inválida.')
  const decipher = createDecipheriv('aes-256-gcm', encryptionKey(), Buffer.from(iv, 'base64url'))

  decipher.setAuthTag(Buffer.from(tag, 'base64url'))

  return Buffer.concat([decipher.update(Buffer.from(encrypted, 'base64url')), decipher.final()]).toString('utf8')
}

export function googleConfig(event: H3Event) {
  const clientId = process.env.GOOGLE_DRIVE_CLIENT_ID
  const clientSecret = process.env.GOOGLE_DRIVE_CLIENT_SECRET

  const redirectUri = process.env.GOOGLE_DRIVE_REDIRECT_URI
    || `${getRequestURL(event).origin}/api/storage/google/callback`

  if (!clientId || !clientSecret)
    throw createError({ statusCode: 503, message: 'A integração Google Drive ainda não foi configurada no servidor.' })

  return { clientId, clientSecret, redirectUri }
}

export async function googleToken(refreshToken: string) {
  const body = new URLSearchParams({
    client_id: process.env.GOOGLE_DRIVE_CLIENT_ID || '',
    client_secret: process.env.GOOGLE_DRIVE_CLIENT_SECRET || '',
    refresh_token: refreshToken,
    grant_type: 'refresh_token',
  })

  const response = await fetch('https://oauth2.googleapis.com/token', { method: 'POST', body })
  if (!response.ok)
    throw createError({ statusCode: 502, message: 'A conexão com o Google Drive expirou. Reconecte-a em Configurações.' })

  return (await response.json() as { access_token: string }).access_token
}

export async function driveRequest<T>(accessToken: string, url: string, init: RequestInit = {}) {
  const response = await fetch(url, {
    ...init,
    headers: { Authorization: `Bearer ${accessToken}`, ...(init.headers || {}) },
  })

  if (!response.ok)
    throw createError({ statusCode: 502, message: `O Google Drive recusou a operação (${response.status}).` })

  return response as Response & { json(): Promise<T> }
}

export async function findOrCreateDriveFolder(accessToken: string, name: string, parentId?: string) {
  const escaped = name.replaceAll('\\', '\\\\').replaceAll('\'', '\\\'')
  const parent = parentId ? ` and '${parentId}' in parents` : ''
  const query = `name = '${escaped}' and mimeType = 'application/vnd.google-apps.folder' and trashed = false${parent}`

  const search = await driveRequest<{ files: { id: string }[] }>(
    accessToken,
    `https://www.googleapis.com/drive/v3/files?q=${encodeURIComponent(query)}&fields=files(id)&spaces=drive`,
  )

  const existing = (await search.json()).files[0]
  if (existing)
    return existing.id

  const created = await driveRequest<{ id: string }>(accessToken, 'https://www.googleapis.com/drive/v3/files?fields=id', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      name,
      mimeType: 'application/vnd.google-apps.folder',
      ...(parentId ? { parents: [parentId] } : {}),
    }),
  })

  return (await created.json()).id
}

export async function getStorageSettings(event: H3Event, companyId: string) {
  const service = serverSupabaseServiceRole(event) as any
  const { data, error } = await service.from('company_storage_settings').select('*').eq('company_id', companyId).maybeSingle()
  if (error)
    throw createError({ statusCode: 500, message: 'Não foi possível carregar a configuração de armazenamento.' })

  return { service, settings: data as any }
}
