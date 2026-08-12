-- ===========================================================================
-- Transferências entre contas bancárias e ajustes de saldo.
--
-- Uma transferência move dinheiro entre duas contas da própria empresa: não é
-- receita nem despesa. Ela é gravada como DOIS lançamentos (saída na origem e
-- entrada no destino) marcados com is_transfer, que o app soma no saldo mas
-- exclui do DRE. Um ajuste de saldo é a mesma coisa com apenas uma perna.
-- ===========================================================================

alter table public.transactions
  add column if not exists is_transfer boolean not null default false,
  add column if not exists transfer_id uuid;

create index if not exists transactions_transfer_id_idx
  on public.transactions (transfer_id) where transfer_id is not null;

alter table public.transactions
  drop constraint if exists transactions_transfer_consistency;

alter table public.transactions
  add constraint transactions_transfer_consistency check (
    (not is_transfer and transfer_id is null)
    or (
      is_transfer
      and transfer_id is not null
      and payable_id is null
      and receivable_id is null
      and settlement_id is null
      and category_id is null
      and not is_reversal
    )
  );

-- ---------------------------------------------------------------------------
create or replace function public.register_account_transfer(
  target_company  uuid,
  from_account    text default null,
  to_account      text default null,
  transfer_amount numeric default 0,
  transfer_date   date default current_date,
  transfer_notes  text default null
) returns uuid
language plpgsql
set search_path to ''
as $$
declare
  new_transfer uuid := gen_random_uuid();
  origem  text := nullif(trim(from_account), '');
  destino text := nullif(trim(to_account), '');
  rotulo  text;
begin
  if not private.can_manage_finance(target_company) then
    raise exception 'Acesso negado';
  end if;
  if transfer_amount is null or transfer_amount <= 0 then
    raise exception 'Informe um valor maior que zero';
  end if;
  if origem is null and destino is null then
    raise exception 'Informe a conta de origem, a de destino, ou ambas';
  end if;
  if origem is not null and destino is not null and origem = destino then
    raise exception 'A conta de origem e a de destino devem ser diferentes';
  end if;

  rotulo := case
    when origem is not null and destino is not null then
      format('Transferência: %s → %s', origem, destino)
    when destino is not null then format('Ajuste de saldo: %s', destino)
    else format('Ajuste de saldo: %s', origem)
  end;

  if origem is not null then
    insert into public.transactions(
      company_id, type, amount, date, description, account,
      cost_center_id, is_transfer, transfer_id
    ) values (
      target_company, 'expense', transfer_amount, transfer_date,
      coalesce(nullif(trim(transfer_notes), ''), rotulo), origem,
      null, true, new_transfer
    );
  end if;

  if destino is not null then
    insert into public.transactions(
      company_id, type, amount, date, description, account,
      cost_center_id, is_transfer, transfer_id
    ) values (
      target_company, 'income', transfer_amount, transfer_date,
      coalesce(nullif(trim(transfer_notes), ''), rotulo), destino,
      null, true, new_transfer
    );
  end if;

  return new_transfer;
end;
$$;

-- ---------------------------------------------------------------------------
create or replace function public.delete_account_transfer(target_transfer uuid)
returns uuid
language plpgsql
set search_path to ''
as $$
declare target_company uuid;
begin
  select company_id into target_company
    from public.transactions
   where transfer_id = target_transfer
   limit 1;

  if target_company is null then
    raise exception 'Transferência não encontrada';
  end if;
  if not private.can_admin_company(target_company) then
    raise exception 'Acesso negado';
  end if;

  delete from public.transactions
   where transfer_id = target_transfer
     and is_transfer;

  return target_transfer;
end;
$$;

grant execute on function public.register_account_transfer(uuid, text, text, numeric, date, text) to authenticated;
grant execute on function public.delete_account_transfer(uuid) to authenticated;
