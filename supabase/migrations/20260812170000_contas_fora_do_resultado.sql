-- ===========================================================================
-- Contas do plano que NÃO são faturamento.
--
-- Aporte de sócio é capital, não receita da operação: entra no caixa mas não
-- pode inflar o faturamento nem o resultado. A conta do plano passa a dizer
-- isso, e cada lançamento carrega o reflexo em `in_result` para os relatórios
-- não precisarem cruzar tabela a cada soma.
-- ===========================================================================

alter table public.chart_accounts
  add column if not exists counts_in_result boolean not null default true;

comment on column public.chart_accounts.counts_in_result is
  'false = movimenta caixa mas fica fora do faturamento/DRE (aportes, capital, ajustes).';

alter table public.transactions
  add column if not exists in_result boolean not null default true;

-- --------------------------------------------------------------- sincronismo
create or replace function public.sync_transaction_in_result()
returns trigger
language plpgsql
set search_path to ''
as $$
begin
  new.in_result :=
    (not new.is_transfer)
    and coalesce(
      (select ca.counts_in_result from public.chart_accounts ca where ca.id = new.category_id),
      true
    );

  return new;
end;
$$;

drop trigger if exists transactions_sync_in_result on public.transactions;
create trigger transactions_sync_in_result
  before insert or update of category_id, is_transfer on public.transactions
  for each row execute function public.sync_transaction_in_result();

-- Se a conta do plano mudar de classificação, os lançamentos acompanham.
create or replace function public.sync_in_result_from_chart_account()
returns trigger
language plpgsql
set search_path to ''
as $$
begin
  if new.counts_in_result is distinct from old.counts_in_result then
    update public.transactions t
       set in_result = (not t.is_transfer) and new.counts_in_result
     where t.category_id = new.id;
  end if;

  return new;
end;
$$;

drop trigger if exists chart_accounts_sync_in_result on public.chart_accounts;
create trigger chart_accounts_sync_in_result
  after update of counts_in_result on public.chart_accounts
  for each row execute function public.sync_in_result_from_chart_account();

-- ------------------------------------------------------------------ ajustes
-- Aportes de sócios saem do faturamento.
update public.chart_accounts set counts_in_result = false where code = '1.3';

-- Recalcula o histórico já existente.
update public.transactions t
   set in_result = (not t.is_transfer)
     and coalesce((select ca.counts_in_result from public.chart_accounts ca where ca.id = t.category_id), true)
 where t.in_result is distinct from (
   (not t.is_transfer)
   and coalesce((select ca.counts_in_result from public.chart_accounts ca where ca.id = t.category_id), true)
 );
