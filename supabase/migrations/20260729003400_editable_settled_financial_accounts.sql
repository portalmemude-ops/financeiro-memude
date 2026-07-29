-- Permite corrigir dados cadastrais de contas antigas sem reescrever o caixa.
-- Valores já liquidados permanecem imutáveis; o valor nominal pode aumentar e
-- o saldo volta a ficar parcial. Vínculos fiscais/comerciais preservam o valor
-- que originou o respectivo documento ou comissão.

create or replace function public.update_payable_entry(
  target_id uuid,
  payload jsonb
) returns public.payables
language plpgsql
security invoker
set search_path = ''
as $$
declare
  p public.payables;
  target_company uuid;
  requested_amount numeric;
  requested_recurrence text;
  requested_supplier uuid;
  requested_employee uuid;
  has_commission boolean;
begin
  target_company := nullif(payload->>'companyId', '')::uuid;
  requested_amount := coalesce(nullif(payload->>'amount', '')::numeric, 0);
  requested_recurrence := coalesce(nullif(payload->>'recurrence', ''), 'once');
  requested_supplier := nullif(payload->>'supplierId', '')::uuid;
  requested_employee := nullif(payload->>'employeeId', '')::uuid;

  if target_company is null then raise exception 'Empresa obrigatoria'; end if;
  if not private.can_manage_finance(target_company) then raise exception 'Acesso negado'; end if;
  if nullif(trim(payload->>'description'), '') is null then raise exception 'Descricao obrigatoria'; end if;
  if requested_amount <= 0 then raise exception 'Valor deve ser positivo'; end if;
  if nullif(payload->>'dueDate', '') is null then raise exception 'Vencimento obrigatorio'; end if;
  if requested_recurrence not in ('once', 'weekly', 'monthly', 'quarterly', 'yearly', 'installment') then
    raise exception 'Recorrencia invalida';
  end if;

  select * into p
    from public.payables
   where id = target_id
   for update;

  if p.id is null or p.company_id <> target_company then raise exception 'Conta a pagar nao encontrada'; end if;
  if requested_amount < p.paid_amount then
    raise exception 'Valor total nao pode ser menor que o valor ja pago';
  end if;

  select exists (
    select 1 from public.commission_splits cs where cs.payable_id = p.id
  ) into has_commission;

  if has_commission
     and (
       requested_amount <> p.amount
       or requested_supplier is distinct from p.supplier_id
       or requested_employee is distinct from p.employee_id
     ) then
    raise exception 'Valor e beneficiario de repasse devem ser ajustados no modulo de comissoes';
  end if;

  update public.payables
     set supplier_id = requested_supplier,
         employee_id = requested_employee,
         description = trim(payload->>'description'),
         amount = requested_amount,
         due_date = (payload->>'dueDate')::date,
         competence_date = nullif(payload->>'competenceDate', '')::date,
         category_id = nullif(payload->>'categoryId', '')::uuid,
         cost_center_id = nullif(payload->>'costCenterId', '')::uuid,
         recurrence = requested_recurrence,
         proof_url = nullif(payload->>'proofUrl', ''),
         notes = nullif(payload->>'notes', ''),
         status = case
           when p.paid_amount = requested_amount and p.paid_amount > 0 then 'paid'
           when p.paid_amount > 0 then 'partial'
           when p.status = 'cancelled' then 'cancelled'
           else 'open'
         end,
         paid_at = case
           when p.paid_amount = requested_amount and p.paid_amount > 0 then p.paid_at
           else null
         end,
         updated_at = now()
   where id = p.id
   returning * into p;

  -- Corrige somente a classificação do caixa histórico. Valor, data, conta e
  -- vínculo com a baixa não são alterados.
  update public.transactions
     set description = case when is_reversal then 'Estorno: ' || p.description else p.description end,
         category_id = p.category_id,
         cost_center_id = p.cost_center_id
   where payable_id = p.id;

  if has_commission then
    update public.commission_splits
       set status = case when p.status = 'paid' then 'paid' else 'pending' end
     where payable_id = p.id;
  end if;

  return p;
end;
$$;

create or replace function public.update_receivable_entry(
  target_id uuid,
  payload jsonb,
  external_invoice jsonb default null
) returns public.receivables
language plpgsql
security invoker
set search_path = ''
as $$
declare
  r public.receivables;
  target_company uuid;
  requested_amount numeric;
  requested_rule text;
  requested_recurrence text;
  existing_invoice public.invoices;
  has_commission boolean;
begin
  target_company := nullif(payload->>'companyId', '')::uuid;
  requested_amount := coalesce(nullif(payload->>'amount', '')::numeric, 0);
  requested_rule := coalesce(nullif(payload->>'invoiceRule', ''), 'on_receive');
  requested_recurrence := coalesce(nullif(payload->>'recurrence', ''), 'once');

  if target_company is null then raise exception 'Empresa obrigatoria'; end if;
  if not private.can_manage_finance(target_company) then raise exception 'Acesso negado'; end if;
  if nullif(trim(payload->>'clientName'), '') is null then raise exception 'Cliente obrigatorio'; end if;
  if nullif(trim(payload->>'description'), '') is null then raise exception 'Descricao obrigatoria'; end if;
  if requested_amount <= 0 then raise exception 'Valor deve ser positivo'; end if;
  if nullif(payload->>'dueDate', '') is null then raise exception 'Data prevista obrigatoria'; end if;
  if requested_rule not in ('immediate', 'on_receive', 'scheduled', 'recurring', 'manual', 'none') then
    raise exception 'Regra fiscal invalida';
  end if;
  if requested_recurrence not in ('once', 'monthly') then raise exception 'Recorrencia invalida'; end if;
  if requested_rule = 'scheduled' and nullif(payload->>'invoiceScheduledDate', '') is null then
    raise exception 'Data de emissao agendada obrigatoria';
  end if;
  if requested_rule = 'recurring'
     and coalesce(nullif(payload->>'invoiceRecurrenceDay', '')::integer, 0) not between 1 and 28 then
    raise exception 'Dia de emissao recorrente deve estar entre 1 e 28';
  end if;

  select * into r
    from public.receivables
   where id = target_id
   for update;

  if r.id is null or r.company_id <> target_company then raise exception 'Conta a receber nao encontrada'; end if;
  if requested_amount < r.received_amount then
    raise exception 'Valor total nao pode ser menor que o valor ja recebido';
  end if;

  select * into existing_invoice
    from public.invoices
   where receivable_id = r.id
     and status <> 'cancelled'
   order by created_at desc
   limit 1;

  if existing_invoice.id is not null
     and (requested_amount <> r.amount or requested_rule <> r.invoice_rule) then
    raise exception 'Valor e regra fiscal nao podem mudar depois que uma NFS-e foi vinculada';
  end if;

  select (
    r.sale_id is not null
    or r.commission_installment_id is not null
    or exists (select 1 from public.commission_installments ci where ci.receivable_id = r.id)
  ) into has_commission;

  if has_commission and requested_amount <> r.amount then
    raise exception 'Valor de conta vinculada a venda ou comissao deve ser ajustado no modulo comercial';
  end if;

  update public.receivables
     set client_name = trim(payload->>'clientName'),
         client_document = nullif(trim(payload->>'clientDocument'), ''),
         description = trim(payload->>'description'),
         amount = requested_amount,
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
           when r.received_amount = requested_amount and r.received_amount > 0 then 'received'
           when r.received_amount > 0 then 'partial'
           when r.status = 'cancelled' then 'cancelled'
           else 'open'
         end,
         received_at = case
           when r.received_amount = requested_amount and r.received_amount > 0 then r.received_at
           else null
         end,
         updated_at = now()
   where id = r.id
   returning * into r;

  update public.transactions
     set description = case when is_reversal then 'Estorno: ' || r.description else r.description end,
         category_id = r.category_id,
         cost_center_id = r.cost_center_id
   where receivable_id = r.id;

  if r.commission_installment_id is not null then
    update public.commission_installments
       set expected_date = r.due_date,
           status = case when r.status = 'received' then 'received' else 'pending' end,
           received_date = case when r.status = 'received' then r.received_at::date else null end
     where id = r.commission_installment_id;
  end if;

  if existing_invoice.id is not null then
    if existing_invoice.source = 'external' then
      if requested_rule <> 'manual'
         or external_invoice is null
         or nullif(trim(external_invoice->>'number'), '') is null then
        raise exception 'Informe os dados da NFS-e externa vinculada';
      end if;

      update public.invoices
         set environment = coalesce(nullif(external_invoice->>'environment', ''), existing_invoice.environment),
             nfse_number = trim(external_invoice->>'number'),
             service_description = r.description,
             taker_name = coalesce(nullif(r.client_name, ''), 'Nao informado'),
             taker_document = coalesce(r.client_document, ''),
             pdf_url = nullif(external_invoice->>'documentUrl', ''),
             issued_at = coalesce(nullif(external_invoice->>'issuedAt', '')::timestamptz, existing_invoice.issued_at),
             updated_at = now()
       where id = existing_invoice.id;
    elsif existing_invoice.status in ('pending', 'error', 'simulated') then
      update public.invoices
         set service_description = r.description,
             taker_name = coalesce(nullif(r.client_name, ''), 'Nao informado'),
             taker_document = coalesce(r.client_document, ''),
             updated_at = now()
       where id = existing_invoice.id;
    end if;
  elsif requested_rule = 'manual' then
    if external_invoice is null
       or nullif(trim(external_invoice->>'number'), '') is null then
      raise exception 'Numero da NFS-e ja emitida e obrigatorio';
    end if;

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
  elsif external_invoice is not null then
    raise exception 'Referencia externa permitida somente para NFS-e ja emitida';
  end if;

  return r;
end;
$$;

revoke all on function public.update_payable_entry(uuid, jsonb) from public, anon;
revoke all on function public.update_receivable_entry(uuid, jsonb, jsonb) from public, anon;

grant execute on function public.update_payable_entry(uuid, jsonb) to authenticated;
grant execute on function public.update_receivable_entry(uuid, jsonb, jsonb) to authenticated;
