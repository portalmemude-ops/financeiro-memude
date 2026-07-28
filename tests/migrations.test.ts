import assert from 'node:assert/strict'
import { readFileSync } from 'node:fs'

const migration = readFileSync(
  new URL(
    '../supabase/migrations/20260728211912_receivables_cash_basis_and_fiscal_modes.sql',
    import.meta.url,
  ),
  'utf8',
)

const legacySettlementMigration = readFileSync(
  new URL(
    '../supabase/migrations/20260728220427_backfill_legacy_receivable_settlements.sql',
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

assert.match(
  migration,
  /Backfill automatico de recebimento legado/,
  'a migracao base deve completar a trilha de baixas de bancos novos',
)

assert.match(
  legacySettlementMigration,
  /insert into public\.settlements[\s\S]+update public\.transactions[\s\S]+set settlement_id = inserted\.id/,
  'o backfill incremental deve criar a baixa e associar a transacao existente',
)

assert.doesNotMatch(
  legacySettlementMigration,
  /insert into public\.transactions/,
  'o backfill nao pode duplicar movimentos de caixa',
)

console.log('Migrations: 5 passaram, 0 falharam.')
