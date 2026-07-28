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

const safeCrudMigration = readFileSync(
  new URL(
    '../supabase/migrations/20260728231500_financial_accounts_safe_crud.sql',
    import.meta.url,
  ),
  'utf8',
)

const hardenedDeleteMigration = readFileSync(
  new URL(
    '../supabase/migrations/20260728232500_harden_financial_account_deletion.sql',
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

assert.match(
  safeCrudMigration,
  /create or replace function public\.delete_payable_entry[\s\S]+?from public\.settlements[\s\S]+?from public\.transactions[\s\S]+?from public\.commission_splits/,
  'a exclusao de contas a pagar deve proteger baixas, transacoes e comissoes',
)

assert.match(
  safeCrudMigration,
  /create or replace function public\.delete_receivable_entry[\s\S]+?from public\.settlements[\s\S]+?from public\.transactions[\s\S]+?from public\.invoices[\s\S]+?from public\.commission_installments/,
  'a exclusao de contas a receber deve proteger caixa, fiscal e comissoes',
)

assert.match(
  safeCrudMigration,
  /revoke delete on public\.payables, public\.receivables from authenticated/,
  'o cliente nao pode contornar as funcoes seguras com DELETE direto',
)

assert.match(
  hardenedDeleteMigration,
  /create trigger guard_payable_delete[\s\S]+?create trigger guard_receivable_delete/,
  'triggers devem proteger toda exclusao, inclusive chamadas diretas',
)

assert.match(
  hardenedDeleteMigration,
  /create or replace function public\.delete_payable_entry[\s\S]+?security invoker[\s\S]+?create or replace function public\.delete_receivable_entry[\s\S]+?security invoker/,
  'os RPCs expostos devem executar com as permissoes do usuario',
)

assert.match(
  hardenedDeleteMigration,
  /create policy payables_delete[\s\S]+?private\.can_manage_finance[\s\S]+?create policy receivables_delete[\s\S]+?private\.can_manage_finance/,
  'a RLS deve limitar exclusoes a perfis financeiros da empresa',
)

console.log('Migrations: 11 passaram, 0 falharam.')
