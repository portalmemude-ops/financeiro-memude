-- ===========================================================================
-- Saldo inicial da conta em 21/05/2025.
--
-- A planilha começou a ser preenchida em 22/05/2025 partindo do zero, ignorando
-- o dinheiro que já estava na conta. Sem isso o saldo acumulado fica negativo em
-- 163 dos 187 dias com movimento — impossível na prática.
--
-- 46.923,84 (extrato de 12/08/2026) − 35.689,98 (soma dos lançamentos) = 11.233,86
--
-- Entra como ajuste de saldo (is_transfer), então soma no caixa e fica fora do
-- DRE: não é receita da operação, é patrimônio que já existia.
-- ===========================================================================
insert into public.transactions (
  company_id, type, amount, date, description, account,
  category_id, cost_center_id, is_transfer, transfer_id
)
select
  '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6'::uuid,
  'income',
  11233.86,
  '2025-05-21'::date,
  'Saldo inicial da conta em 21/05/2025 (dinheiro que já existia antes do início do controle na planilha)',
  'Conta MeMude',
  null, null, true, gen_random_uuid()
where not exists (
  select 1 from public.transactions
   where is_transfer and description like 'Saldo inicial da conta%'
);
