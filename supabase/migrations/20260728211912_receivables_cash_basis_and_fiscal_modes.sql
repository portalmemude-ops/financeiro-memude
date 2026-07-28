-- Recebiveis v2: regime de caixa, idempotencia, estornos e modos fiscais.
-- A migracao e aditiva e preserva o historico financeiro existente.

alter table public.receivables
  add column if not exists invoice_scheduled_date date,
  add column if not exists invoice_recurrence_day smallint;

alter table public.settlements
  add column if not exists request_id uuid,
  add column if not exists notes text;

alter table public.transactions
  add column if not exists settlement_id uuid references public.settlements(id),
  add column if not exists is_reversal boolean not null default false,
  add column if not exists reversal_of uuid references public.transactions(id);

alter table public.invoices
  add column if not exists source text not null default 'system';

-- Recupera a intencao de registros legados cujos campos de agendamento ainda
-- nao existiam fisicamente no banco.
update public.receivables
   set invoice_scheduled_date = due_date
 where invoice_rule = 'scheduled'
   and invoice_scheduled_date is null;

update public.receivables
   set invoice_recurrence_day = least(28, extract(day from due_date)::integer)
 where invoice_rule = 'recurring'
   and invoice_recurrence_day is null;

alter table public.invoices drop constraint if exists invoices_source_check;
alter table public.invoices add constraint invoices_source_check
  check (source in ('system', 'external'));

alter table public.settlements drop constraint if exists settlements_payment_method_check;
alter table public.settlements add constraint settlements_payment_method_check
  check (
    payment_method is null
    or payment_method in ('pix', 'transfer', 'boleto', 'card', 'cash', 'check', 'other')
  );

alter table public.receivables drop constraint if exists receivables_invoice_schedule_check;
alter table public.receivables add constraint receivables_invoice_schedule_check
  check (
    (invoice_rule = 'scheduled' and invoice_scheduled_date is not null)
    or (invoice_rule <> 'scheduled' and invoice_scheduled_date is null)
  );

alter table public.receivables drop constraint if exists receivables_invoice_recurrence_day_check;
alter table public.receivables add constraint receivables_invoice_recurrence_day_check
  check (
    (invoice_rule = 'recurring' and invoice_recurrence_day between 1 and 28)
    or (invoice_rule <> 'recurring' and invoice_recurrence_day is null)
  );

-- Valida novos registros sem impedir o rollout por eventual legado inconsistente.
alter table public.receivables drop constraint if exists receivables_cash_status_consistency;
alter table public.receivables add constraint receivables_cash_status_consistency
  check (
    (status in ('open', 'overdue') and received_amount = 0 and received_at is null)
    or (status = 'partial' and received_amount > 0 and received_amount < amount and received_at is null)
    or (status = 'received' and received_amount = amount and received_at is not null)
    or (status = 'cancelled' and received_amount = 0)
  ) not valid;

alter table public.transactions drop constraint if exists transactions_reversal_consistency;
alter table public.transactions add constraint transactions_reversal_consistency
  check (
    (is_reversal and reversal_of is not null)
    or (not is_reversal and reversal_of is null)
  );

create unique index if not exists settlements_request_id_uidx
  on public.settlements(request_id)
  where request_id is not null;

create unique index if not exists settlements_reversal_of_uidx
  on public.settlements(reversal_of)
  where reversal_of is not null;

create unique index if not exists transactions_settlement_id_uidx
  on public.transactions(settlement_id)
  where settlement_id is not null;

create index if not exists transactions_reversal_of_idx
  on public.transactions(reversal_of)
  where reversal_of is not null;

create unique index if not exists invoices_active_receivable_uidx
  on public.invoices(receivable_id)
  where receivable_id is not null and status <> 'cancelled';

-- Baixa idempotente. Toda confirmacao gera settlement + transaction + saldo
-- do recebivel na mesma transacao curta, sob bloqueio da linha financeira.
drop function if exists public.settle_receivable(uuid,numeric,timestamptz,text,text,text);

create or replace function public.settle_receivable(
  target_id uuid,
  settle_amount numeric,
  settle_at timestamptz default now(),
  method text default null,
  account_name text default null,
  proof text default null,
  request_key uuid default gen_random_uuid(),
  settlement_note text default null
) returns public.receivables
language plpgsql
security invoker
set search_path = ''
as $$
declare
  r public.receivables;
  existing public.settlements;
  new_settlement_id uuid;
  remaining numeric;
begin
  select *
    into r
    from public.receivables
   where id = target_id
   for update;

  if r.id is null then
    raise exception 'Conta a receber nao encontrada';
  end if;
  if not private.can_manage_finance(r.company_id) then
    raise exception 'Acesso negado';
  end if;

  if request_key is not null then
    select *
      into existing
      from public.settlements
     where request_id = request_key;

    if existing.id is not null then
      if existing.receivable_id = r.id
         and existing.type = 'receipt'
         and existing.amount = settle_amount then
        return r;
      end if;
      raise exception 'Chave de idempotencia reutilizada em outra operacao';
    end if;
  end if;

  if r.status = 'cancelled' then
    raise exception 'Conta cancelada nao pode ser recebida';
  end if;

  remaining := r.amount - r.received_amount;
  if settle_amount <= 0 or settle_amount > remaining then
    raise exception 'Valor de recebimento invalido';
  end if;
  if method is not null
     and method not in ('pix', 'transfer', 'boleto', 'card', 'cash', 'check', 'other') then
    raise exception 'Forma de recebimento invalida';
  end if;

  insert into public.settlements(
    company_id,
    receivable_id,
    type,
    amount,
    settled_at,
    payment_method,
    account,
    proof_url,
    request_id,
    notes,
    created_by
  )
  values (
    r.company_id,
    r.id,
    'receipt',
    settle_amount,
    settle_at,
    method,
    account_name,
    proof,
    request_key,
    settlement_note,
    (select auth.uid())
  )
  returning id into new_settlement_id;

  insert into public.transactions(
    company_id,
    type,
    amount,
    date,
    description,
    account,
    category_id,
    cost_center_id,
    receivable_id,
    settlement_id
  )
  values (
    r.company_id,
    'income',
    settle_amount,
    settle_at::date,
    r.description,
    account_name,
    r.category_id,
    r.cost_center_id,
    r.id,
    new_settlement_id
  );

  update public.receivables
     set received_amount = received_amount + settle_amount,
         received_at = case
           when received_amount + settle_amount = amount then settle_at
           else null
         end,
         account = coalesce(account_name, account),
         proof_url = coalesce(proof, proof_url),
         status = case
           when received_amount + settle_amount = amount then 'received'
           else 'partial'
         end,
         updated_at = now()
   where id = r.id
   returning * into r;

  if r.status = 'received' and r.commission_installment_id is not null then
    update public.commission_installments
       set status = 'received',
           received_date = settle_at::date
     where id = r.commission_installment_id;

    update public.commissions c
       set status = case
         when not exists (
           select 1
             from public.commission_installments ci
            where ci.commission_id = c.id
              and ci.status <> 'received'
         ) then 'received'
         when exists (
           select 1
             from public.commission_installments ci
            where ci.commission_id = c.id
              and ci.status = 'received'
         ) then 'partial'
         else 'pending'
       end
     where c.id = (
       select ci.commission_id
         from public.commission_installments ci
        where ci.id = r.commission_installment_id
     );
  end if;

  return r;
end;
$$;

-- Cadastro unico para contas agendadas ou ja recebidas. O status nunca vem do
-- cliente: uma conta so se torna recebida por meio da baixa acima.
create or replace function public.save_receivable_entry(
  target_id uuid,
  payload jsonb,
  initial_receipt jsonb default null,
  external_invoice jsonb default null
) returns public.receivables
language plpgsql
security invoker
set search_path = ''
as $$
declare
  r public.receivables;
  target_company uuid;
  requested_rule text;
  requested_recurrence text;
  existing_invoice public.invoices;
  receipt_amount numeric;
  receipt_key uuid;
begin
  target_company := nullif(payload->>'companyId', '')::uuid;
  requested_rule := coalesce(nullif(payload->>'invoiceRule', ''), 'on_receive');
  requested_recurrence := coalesce(nullif(payload->>'recurrence', ''), 'once');

  if target_company is null then
    raise exception 'Empresa obrigatoria';
  end if;
  if not private.can_manage_finance(target_company) then
    raise exception 'Acesso negado';
  end if;
  if nullif(trim(payload->>'clientName'), '') is null then
    raise exception 'Cliente obrigatorio';
  end if;
  if nullif(trim(payload->>'description'), '') is null then
    raise exception 'Descricao obrigatoria';
  end if;
  if coalesce(nullif(payload->>'amount', '')::numeric, 0) <= 0 then
    raise exception 'Valor deve ser positivo';
  end if;
  if nullif(payload->>'dueDate', '') is null then
    raise exception 'Data prevista obrigatoria';
  end if;
  if requested_rule not in ('immediate', 'on_receive', 'scheduled', 'recurring', 'manual', 'none') then
    raise exception 'Regra fiscal invalida';
  end if;
  if requested_recurrence not in ('once', 'monthly') then
    raise exception 'Recorrencia invalida';
  end if;
  if requested_rule = 'scheduled' and nullif(payload->>'invoiceScheduledDate', '') is null then
    raise exception 'Data de emissao agendada obrigatoria';
  end if;
  if requested_rule = 'recurring'
     and coalesce(nullif(payload->>'invoiceRecurrenceDay', '')::integer, 0) not between 1 and 28 then
    raise exception 'Dia de emissao recorrente deve estar entre 1 e 28';
  end if;

  if target_id is null then
    insert into public.receivables(
      company_id,
      client_name,
      client_document,
      sale_id,
      commission_installment_id,
      description,
      amount,
      due_date,
      competence_date,
      category_id,
      cost_center_id,
      invoice_rule,
      invoice_scheduled_date,
      invoice_recurrence_day,
      recurrence,
      status,
      received_amount,
      notes
    )
    values (
      target_company,
      trim(payload->>'clientName'),
      nullif(trim(payload->>'clientDocument'), ''),
      nullif(payload->>'saleId', '')::uuid,
      nullif(payload->>'commissionInstallmentId', '')::uuid,
      trim(payload->>'description'),
      (payload->>'amount')::numeric,
      (payload->>'dueDate')::date,
      nullif(payload->>'competenceDate', '')::date,
      nullif(payload->>'categoryId', '')::uuid,
      nullif(payload->>'costCenterId', '')::uuid,
      requested_rule,
      case
        when requested_rule = 'scheduled' then (payload->>'invoiceScheduledDate')::date
        else null
      end,
      case
        when requested_rule = 'recurring' then (payload->>'invoiceRecurrenceDay')::smallint
        else null
      end,
      requested_recurrence,
      'open',
      0,
      nullif(payload->>'notes', '')
    )
    returning * into r;
  else
    select *
      into r
      from public.receivables
     where id = target_id
     for update;

    if r.id is null or r.company_id <> target_company then
      raise exception 'Conta a receber nao encontrada';
    end if;
    if r.status = 'cancelled' then
      raise exception 'Conta cancelada nao pode ser editada';
    end if;
    if (payload->>'amount')::numeric < r.received_amount then
      raise exception 'Valor total nao pode ser menor que o valor ja recebido';
    end if;
    if r.received_amount > 0 and (payload->>'amount')::numeric <> r.amount then
      raise exception 'Valor total nao pode ser alterado depois de um recebimento';
    end if;

    select *
      into existing_invoice
      from public.invoices
     where receivable_id = r.id
       and status <> 'cancelled'
     limit 1;

    if existing_invoice.id is not null and requested_rule <> r.invoice_rule then
      raise exception 'Regra fiscal nao pode ser alterada depois que uma NFS-e foi vinculada';
    end if;

    update public.receivables
       set client_name = trim(payload->>'clientName'),
           client_document = nullif(trim(payload->>'clientDocument'), ''),
           description = trim(payload->>'description'),
           amount = (payload->>'amount')::numeric,
           due_date = (payload->>'dueDate')::date,
           competence_date = nullif(payload->>'competenceDate', '')::date,
           category_id = nullif(payload->>'categoryId', '')::uuid,
           cost_center_id = nullif(payload->>'costCenterId', '')::uuid,
           invoice_rule = requested_rule,
           invoice_scheduled_date = case
             when requested_rule = 'scheduled' then (payload->>'invoiceScheduledDate')::date
             else null
           end,
           invoice_recurrence_day = case
             when requested_rule = 'recurring' then (payload->>'invoiceRecurrenceDay')::smallint
             else null
           end,
           recurrence = requested_recurrence,
           notes = nullif(payload->>'notes', ''),
           status = case
             when received_amount = amount and received_amount > 0 then 'received'
             when received_amount > 0 then 'partial'
             else 'open'
           end,
           updated_at = now()
     where id = r.id
     returning * into r;
  end if;

  if requested_rule = 'manual' then
    if nullif(trim(external_invoice->>'number'), '') is null then
      raise exception 'Numero da NFS-e ja emitida e obrigatorio';
    end if;

    select *
      into existing_invoice
      from public.invoices
     where receivable_id = r.id
       and status <> 'cancelled'
     limit 1;

    if existing_invoice.id is null then
      insert into public.invoices(
        company_id,
        receivable_id,
        source,
        status,
        environment,
        provider,
        nfse_number,
        service_description,
        amount,
        taker_name,
        taker_document,
        pdf_url,
        issued_at,
        created_by
      )
      values (
        r.company_id,
        r.id,
        'external',
        'issued',
        coalesce(nullif(external_invoice->>'environment', ''), 'producao'),
        'external',
        trim(external_invoice->>'number'),
        r.description,
        r.amount,
        coalesce(nullif(r.client_name, ''), 'Nao informado'),
        coalesce(r.client_document, ''),
        nullif(external_invoice->>'documentUrl', ''),
        coalesce(nullif(external_invoice->>'issuedAt', '')::timestamptz, now()),
        (select auth.uid())
      );
    elsif existing_invoice.source <> 'external' then
      raise exception 'A conta ja possui outra NFS-e vinculada';
    else
      update public.invoices
         set environment = coalesce(nullif(external_invoice->>'environment', ''), 'producao'),
             nfse_number = trim(external_invoice->>'number'),
             service_description = r.description,
             amount = r.amount,
             taker_name = coalesce(nullif(r.client_name, ''), 'Nao informado'),
             taker_document = coalesce(r.client_document, ''),
             pdf_url = nullif(external_invoice->>'documentUrl', ''),
             issued_at = coalesce(
               nullif(external_invoice->>'issuedAt', '')::timestamptz,
               existing_invoice.issued_at,
               now()
             ),
             updated_at = now()
       where id = existing_invoice.id;
    end if;
  elsif external_invoice is not null then
    raise exception 'Referencia externa permitida somente para NFS-e ja emitida';
  end if;

  if initial_receipt is not null then
    receipt_amount := coalesce(
      nullif(initial_receipt->>'amount', '')::numeric,
      r.amount - r.received_amount
    );
    receipt_key := coalesce(
      nullif(initial_receipt->>'requestId', '')::uuid,
      gen_random_uuid()
    );

    select public.settle_receivable(
      target_id := r.id,
      settle_amount := receipt_amount,
      settle_at := coalesce(
        nullif(initial_receipt->>'receivedAt', '')::timestamptz,
        now()
      ),
      method := nullif(initial_receipt->>'method', ''),
      account_name := nullif(initial_receipt->>'account', ''),
      proof := nullif(initial_receipt->>'proofUrl', ''),
      request_key := receipt_key,
      settlement_note := nullif(initial_receipt->>'notes', '')
    )
    into r;
  end if;

  return r;
end;
$$;

-- Estorno contabil por contrapartida: preserva a baixa e a transacao originais.
create or replace function public.reverse_receivable_settlement(
  target_settlement uuid,
  reversed_at timestamptz default now(),
  reversal_reason text default null,
  request_key uuid default gen_random_uuid()
) returns public.receivables
language plpgsql
security invoker
set search_path = ''
as $$
declare
  original public.settlements;
  existing public.settlements;
  r public.receivables;
  original_transaction public.transactions;
  reversal_settlement_id uuid;
  new_received numeric;
begin
  select *
    into original
    from public.settlements
   where id = target_settlement
     and type = 'receipt';

  if original.id is null then
    raise exception 'Recebimento nao encontrado';
  end if;

  select *
    into r
    from public.receivables
   where id = original.receivable_id
   for update;

  if r.id is null then
    raise exception 'Conta a receber nao encontrada';
  end if;
  if not private.can_manage_finance(r.company_id) then
    raise exception 'Acesso negado';
  end if;

  if request_key is not null then
    select *
      into existing
      from public.settlements
     where request_id = request_key;

    if existing.id is not null then
      if existing.type = 'reversal'
         and existing.reversal_of = original.id then
        return r;
      end if;
      raise exception 'Chave de idempotencia reutilizada em outra operacao';
    end if;
  end if;

  select *
    into original
    from public.settlements
   where id = target_settlement
   for update;

  if exists (
    select 1
      from public.settlements s
     where s.reversal_of = original.id
  ) then
    raise exception 'Recebimento ja estornado';
  end if;
  if r.received_amount < original.amount then
    raise exception 'Saldo recebido insuficiente para estorno';
  end if;

  select *
    into original_transaction
    from public.transactions
   where settlement_id = original.id
   limit 1;

  if original_transaction.id is null then
    raise exception 'Transacao original do recebimento nao encontrada';
  end if;

  insert into public.settlements(
    company_id,
    receivable_id,
    type,
    amount,
    settled_at,
    payment_method,
    account,
    proof_url,
    reversal_of,
    request_id,
    notes,
    created_by
  )
  values (
    original.company_id,
    original.receivable_id,
    'reversal',
    original.amount,
    reversed_at,
    original.payment_method,
    original.account,
    original.proof_url,
    original.id,
    request_key,
    reversal_reason,
    (select auth.uid())
  )
  returning id into reversal_settlement_id;

  insert into public.transactions(
    company_id,
    type,
    amount,
    date,
    description,
    account,
    category_id,
    cost_center_id,
    receivable_id,
    settlement_id,
    is_reversal,
    reversal_of
  )
  values (
    r.company_id,
    'income',
    original.amount,
    reversed_at::date,
    'Estorno: ' || r.description,
    original.account,
    r.category_id,
    r.cost_center_id,
    r.id,
    reversal_settlement_id,
    true,
    original_transaction.id
  );

  new_received := r.received_amount - original.amount;

  update public.receivables
     set received_amount = new_received,
         received_at = null,
         status = case
           when new_received = 0 then 'open'
           else 'partial'
         end,
         updated_at = now()
   where id = r.id
   returning * into r;

  if r.commission_installment_id is not null then
    update public.commission_installments
       set status = case when r.status = 'received' then 'received' else 'pending' end,
           received_date = case when r.status = 'received' then r.received_at::date else null end
     where id = r.commission_installment_id;

    update public.commissions c
       set status = case
         when not exists (
           select 1
             from public.commission_installments ci
            where ci.commission_id = c.id
              and ci.status <> 'received'
         ) then 'received'
         when exists (
           select 1
             from public.commission_installments ci
            where ci.commission_id = c.id
              and ci.status = 'received'
         ) then 'partial'
         else 'pending'
       end
     where c.id = (
       select ci.commission_id
         from public.commission_installments ci
        where ci.id = r.commission_installment_id
     );
  end if;

  return r;
end;
$$;

create or replace function public.cancel_receivable(target_id uuid)
returns public.receivables
language plpgsql
security invoker
set search_path = ''
as $$
declare
  r public.receivables;
begin
  select *
    into r
    from public.receivables
   where id = target_id
   for update;

  if r.id is null then
    raise exception 'Conta a receber nao encontrada';
  end if;
  if not private.can_manage_finance(r.company_id) then
    raise exception 'Acesso negado';
  end if;
  if r.received_amount > 0 then
    raise exception 'Estorne os recebimentos antes de cancelar a conta';
  end if;

  update public.receivables
     set status = 'cancelled',
         updated_at = now()
   where id = r.id
   returning * into r;

  return r;
end;
$$;

revoke all on function public.settle_receivable(
  uuid,numeric,timestamptz,text,text,text,uuid,text
) from public, anon;
revoke all on function public.save_receivable_entry(
  uuid,jsonb,jsonb,jsonb
) from public, anon;
revoke all on function public.reverse_receivable_settlement(
  uuid,timestamptz,text,uuid
) from public, anon;
revoke all on function public.cancel_receivable(uuid) from public, anon;

grant execute on function public.settle_receivable(
  uuid,numeric,timestamptz,text,text,text,uuid,text
) to authenticated;
grant execute on function public.save_receivable_entry(
  uuid,jsonb,jsonb,jsonb
) to authenticated;
grant execute on function public.reverse_receivable_settlement(
  uuid,timestamptz,text,uuid
) to authenticated;
grant execute on function public.cancel_receivable(uuid) to authenticated;
