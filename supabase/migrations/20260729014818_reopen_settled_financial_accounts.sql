-- Reabertura contabil segura de contas pagas/recebidas.
-- Preserva o historico e neutraliza o caixa por transacoes de estorno.

-- Pagamentos legados criavam apenas transactions. Materializa settlements
-- correspondentes e liga os dois lados antes de habilitar a reabertura.
with legacy_payments as materialized (
  select
    gen_random_uuid() as settlement_id,
    t.id as transaction_id,
    t.company_id,
    t.payable_id,
    t.amount,
    t.date,
    t.account,
    t.created_at,
    case lower(p.payment_method)
      when 'pix' then 'pix'
      when 'cartão' then 'card'
      when 'cartao' then 'card'
      when 'transferência' then 'transfer'
      when 'transferencia' then 'transfer'
      when 'boleto' then 'boleto'
      when 'dinheiro' then 'cash'
      when 'cheque' then 'check'
      else null
    end as payment_method,
    p.proof_url,
    (
      select cm.user_id
        from public.company_members cm
       where cm.company_id = t.company_id
       order by case cm.role when 'super_admin' then 0 when 'admin' then 1 else 2 end,
                cm.user_id
       limit 1
    ) as created_by
  from public.transactions t
  join public.payables p on p.id = t.payable_id
  where t.type = 'expense'
    and not t.is_reversal
    and t.settlement_id is null
    and t.payable_id is not null
), inserted as (
  insert into public.settlements(
    id, company_id, payable_id, type, amount, settled_at, payment_method,
    account, proof_url, notes, created_by, created_at
  )
  select
    settlement_id, company_id, payable_id, 'payment', amount,
    date::timestamptz, payment_method, account, proof_url,
    'Backfill automatico de pagamento legado', created_by, created_at
  from legacy_payments
  where created_by is not null
  returning id
)
update public.transactions t
   set settlement_id = legacy.settlement_id
  from legacy_payments legacy
 where t.id = legacy.transaction_id
   and exists (select 1 from inserted i where i.id = legacy.settlement_id);

-- Toda nova baixa de pagamento passa a ser idempotente e liga settlement e
-- transaction, exatamente como ja ocorre no contas a receber.
drop function if exists public.settle_payable(uuid,numeric,timestamptz,text,text,text);

create or replace function public.settle_payable(
  target_id uuid,
  settle_amount numeric,
  settle_at timestamptz default now(),
  method text default null,
  account_name text default null,
  proof text default null,
  request_key uuid default gen_random_uuid()
) returns public.payables
language plpgsql
security invoker
set search_path = ''
as $$
declare
  p public.payables;
  existing public.settlements;
  new_settlement_id uuid;
  remaining numeric;
begin
  select *
    into p
    from public.payables
   where id = target_id
   for update;

  if p.id is null then raise exception 'Conta a pagar nao encontrada'; end if;
  if not private.can_manage_finance(p.company_id) then raise exception 'Acesso negado'; end if;

  if request_key is not null then
    select * into existing
      from public.settlements
     where request_id = request_key;

    if existing.id is not null then
      if existing.payable_id = p.id
         and existing.type = 'payment'
         and existing.amount = settle_amount then
        return p;
      end if;
      raise exception 'Chave de idempotencia reutilizada em outra operacao';
    end if;
  end if;

  if p.status = 'cancelled' then raise exception 'Conta cancelada nao pode ser paga'; end if;
  remaining := p.amount - p.paid_amount;
  if settle_amount <= 0 or settle_amount > remaining then raise exception 'Valor de pagamento invalido'; end if;
  if method is not null
     and method not in ('pix', 'transfer', 'boleto', 'card', 'cash', 'check', 'other') then
    raise exception 'Forma de pagamento invalida';
  end if;

  insert into public.settlements(
    company_id, payable_id, type, amount, settled_at, payment_method,
    account, proof_url, request_id, created_by
  )
  values (
    p.company_id, p.id, 'payment', settle_amount, settle_at, method,
    account_name, proof, request_key, (select auth.uid())
  )
  returning id into new_settlement_id;

  insert into public.transactions(
    company_id, type, amount, date, description, account, category_id,
    cost_center_id, payable_id, settlement_id
  )
  values (
    p.company_id, 'expense', settle_amount, settle_at::date, p.description,
    account_name, p.category_id, p.cost_center_id, p.id, new_settlement_id
  );

  update public.payables
     set paid_amount = paid_amount + settle_amount,
         paid_at = case when paid_amount + settle_amount = amount then settle_at else null end,
         payment_method = coalesce(method, payment_method),
         account = coalesce(account_name, account),
         proof_url = coalesce(proof, proof_url),
         status = case when paid_amount + settle_amount = amount then 'paid' else 'partial' end,
         updated_at = now()
   where id = p.id
   returning * into p;

  if p.status = 'paid' then
    update public.commission_splits
       set status = 'paid'
     where payable_id = p.id
       and status = 'pending';
  end if;

  return p;
end;
$$;

create or replace function public.reverse_payable_settlement(
  target_settlement uuid,
  reversed_at timestamptz default now(),
  reversal_reason text default null,
  request_key uuid default gen_random_uuid()
) returns public.payables
language plpgsql
security invoker
set search_path = ''
as $$
declare
  original public.settlements;
  existing public.settlements;
  p public.payables;
  original_transaction public.transactions;
  reversal_settlement_id uuid;
  new_paid numeric;
begin
  select *
    into original
    from public.settlements
   where id = target_settlement
     and type = 'payment';

  if original.id is null then raise exception 'Pagamento nao encontrado'; end if;

  select *
    into p
    from public.payables
   where id = original.payable_id
   for update;

  if p.id is null then raise exception 'Conta a pagar nao encontrada'; end if;
  if not private.can_manage_finance(p.company_id) then raise exception 'Acesso negado'; end if;

  if request_key is not null then
    select * into existing
      from public.settlements
     where request_id = request_key;

    if existing.id is not null then
      if existing.type = 'reversal' and existing.reversal_of = original.id then
        return p;
      end if;
      raise exception 'Chave de idempotencia reutilizada em outra operacao';
    end if;
  end if;

  select *
    into original
    from public.settlements
   where id = target_settlement
   for update;

  if exists (select 1 from public.settlements s where s.reversal_of = original.id) then
    raise exception 'Pagamento ja estornado';
  end if;
  if p.paid_amount < original.amount then raise exception 'Saldo pago insuficiente para estorno'; end if;

  select *
    into original_transaction
    from public.transactions
   where settlement_id = original.id
   limit 1;

  if original_transaction.id is null then
    raise exception 'Transacao original do pagamento nao encontrada';
  end if;

  insert into public.settlements(
    company_id, payable_id, type, amount, settled_at, payment_method,
    account, proof_url, reversal_of, request_id, notes, created_by
  )
  values (
    original.company_id, original.payable_id, 'reversal', original.amount,
    reversed_at, original.payment_method, original.account, original.proof_url,
    original.id, request_key, nullif(trim(reversal_reason), ''), (select auth.uid())
  )
  returning id into reversal_settlement_id;

  insert into public.transactions(
    company_id, type, amount, date, description, account, category_id,
    cost_center_id, payable_id, settlement_id, is_reversal, reversal_of
  )
  values (
    p.company_id, 'expense', original.amount, reversed_at::date,
    'Estorno: ' || p.description, original.account, p.category_id,
    p.cost_center_id, p.id, reversal_settlement_id, true,
    original_transaction.id
  );

  new_paid := p.paid_amount - original.amount;

  update public.payables
     set paid_amount = new_paid,
         paid_at = null,
         status = case when new_paid = 0 then 'open' else 'partial' end,
         updated_at = now()
   where id = p.id
   returning * into p;

  update public.commission_splits
     set status = 'pending'
   where payable_id = p.id
     and status = 'paid';

  return p;
end;
$$;

-- Reabre a conta inteira em uma unica transacao. Se houver varias baixas
-- parciais, todas as baixas ainda ativas sao neutralizadas.
create or replace function public.reopen_payable(
  target_id uuid,
  reversal_reason text
) returns public.payables
language plpgsql
security invoker
set search_path = ''
as $$
declare
  p public.payables;
  active_payment record;
begin
  select * into p
    from public.payables
   where id = target_id
   for update;

  if p.id is null then raise exception 'Conta a pagar nao encontrada'; end if;
  if not private.can_manage_finance(p.company_id) then raise exception 'Acesso negado'; end if;
  if nullif(trim(reversal_reason), '') is null then raise exception 'Motivo do estorno obrigatorio'; end if;

  for active_payment in
    select s.id
      from public.settlements s
     where s.payable_id = p.id
       and s.type = 'payment'
       and not exists (
         select 1 from public.settlements reversal where reversal.reversal_of = s.id
       )
     order by s.settled_at desc, s.created_at desc
  loop
    p := public.reverse_payable_settlement(
      active_payment.id, now(), reversal_reason, gen_random_uuid()
    );
  end loop;

  if p.paid_amount > 0 then
    raise exception 'Existem pagamentos sem historico contabil que impedem a reabertura';
  end if;

  return p;
end;
$$;

create or replace function public.reopen_receivable(
  target_id uuid,
  reversal_reason text
) returns public.receivables
language plpgsql
security invoker
set search_path = ''
as $$
declare
  r public.receivables;
  active_receipt record;
begin
  select * into r
    from public.receivables
   where id = target_id
   for update;

  if r.id is null then raise exception 'Conta a receber nao encontrada'; end if;
  if not private.can_manage_finance(r.company_id) then raise exception 'Acesso negado'; end if;
  if nullif(trim(reversal_reason), '') is null then raise exception 'Motivo do estorno obrigatorio'; end if;

  for active_receipt in
    select s.id
      from public.settlements s
     where s.receivable_id = r.id
       and s.type = 'receipt'
       and not exists (
         select 1 from public.settlements reversal where reversal.reversal_of = s.id
       )
     order by s.settled_at desc, s.created_at desc
  loop
    r := public.reverse_receivable_settlement(
      active_receipt.id, now(), reversal_reason, gen_random_uuid()
    );
  end loop;

  if r.received_amount > 0 then
    raise exception 'Existem recebimentos sem historico contabil que impedem a reabertura';
  end if;

  return r;
end;
$$;

revoke all on function public.settle_payable(
  uuid,numeric,timestamptz,text,text,text,uuid
) from public, anon;
revoke all on function public.reverse_payable_settlement(
  uuid,timestamptz,text,uuid
) from public, anon;
revoke all on function public.reopen_payable(uuid,text) from public, anon;
revoke all on function public.reopen_receivable(uuid,text) from public, anon;

grant execute on function public.settle_payable(
  uuid,numeric,timestamptz,text,text,text,uuid
) to authenticated;
grant execute on function public.reverse_payable_settlement(
  uuid,timestamptz,text,uuid
) to authenticated;
grant execute on function public.reopen_payable(uuid,text) to authenticated;
grant execute on function public.reopen_receivable(uuid,text) to authenticated;
