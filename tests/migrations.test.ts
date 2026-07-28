import assert from 'node:assert/strict'
import { readFileSync } from 'node:fs'

const migration = readFileSync(
  new URL(
    '../supabase/migrations/20260728211912_receivables_cash_basis_and_fiscal_modes.sql',
    import.meta.url,
  ),
  'utf8',
)

assert.match(
  migration,
  /select \* from public\.settle_receivable\([\s\S]+?\)\s+into r;/,
  'o recebimento inicial deve atribuir o retorno composto por meio de FROM',
)

assert.doesNotMatch(
  migration,
  /select public\.settle_receivable\([\s\S]+?\)\s+into r;/,
  'a forma escalar invalida nao pode voltar para a migracao base',
)

console.log('Migrations: 2 passaram, 0 falharam.')
