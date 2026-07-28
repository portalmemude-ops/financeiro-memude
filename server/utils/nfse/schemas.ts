import type { H3Event } from 'h3'
import { z } from 'zod'

const limitedText = (max: number) => z.string().trim().min(1).max(max)
const optionalText = (max: number) => z.string().trim().max(max).optional()

const addressSchema = z.object({
  logradouro: optionalText(200),
  numero: optionalText(30),
  complemento: optionalText(100),
  bairro: optionalText(100),
  cidadeIbge: z.string().regex(/^\d{7}$/).optional(),
  uf: z.string().regex(/^[A-Z]{2}$/).optional(),
  cep: z.string().regex(/^\d{8}$/).optional(),
}).strict()

export const emitirRequestSchema = z.object({
  companyId: z.uuid(),
  invoiceId: z.uuid(),
  invoice: z.object({
    rpsSeries: optionalText(10).default('1'),
    rpsType: z.number().int().min(1).max(3).optional().default(1),
    dataEmissao: z.iso.datetime().optional(),
    competencia: z.string().regex(/^\d{4}-\d{2}$/).optional(),
    lc116Item: limitedText(20),
    ctiss: optionalText(30),
    cnaeCode: optionalText(20),
    issRate: z.number().min(0).max(100),
    issRetido: z.boolean().optional().default(false),
    serviceDescription: limitedText(2_000),
    amount: z.number().positive().max(999_999_999.99),
    deductionsAmount: z.number().min(0).max(999_999_999.99).optional(),
    municipioIbge: z.string().regex(/^\d{7}$/).optional(),
    taker: z.object({
      name: limitedText(200),
      document: z.string().transform(value => value.replace(/\D/g, '')).pipe(z.string().min(11).max(14)),
      email: z.email().max(254).optional(),
      inscricaoMunicipal: optionalText(30),
      address: addressSchema.optional(),
    }).strict(),
  }).strict(),
}).strict()

export const consultarRequestSchema = z.object({
  companyId: z.uuid(),
  invoiceId: z.uuid(),
  rpsNumber: z.string().regex(/^\d{1,15}$/),
  rpsSeries: optionalText(10).default('1'),
  rpsType: z.number().int().min(1).max(3).optional().default(1),
}).strict()

export const cancelarRequestSchema = z.object({
  companyId: z.uuid(),
  invoiceId: z.uuid(),
  numeroNfse: limitedText(30),
  codigoMunicipio: z.string().regex(/^\d{7}$/).optional(),
  codigoCancelamento: z.enum(['1', '2', '3', '4']).default('1'),
  motivo: limitedText(500),
}).strict()

export async function parseBody<T>(event: H3Event, schema: z.ZodType<T>): Promise<T> {
  const parsed = schema.safeParse(await readBody(event))
  if (!parsed.success) {
    throw createError({
      statusCode: 422,
      statusMessage: 'Dados inválidos',
      message: parsed.error.issues.map(issue => `${issue.path.join('.')}: ${issue.message}`).join('; '),
    })
  }

  return parsed.data
}
