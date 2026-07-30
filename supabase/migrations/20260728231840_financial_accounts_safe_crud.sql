-- CRUD seguro de contas financeiras.
-- A edicao de contas a pagar passa por uma funcao transacional e a exclusao
-- permanente de contas a pagar/receber fica restrita a lancamentos sem
-- qualquer historico financeiro, fiscal ou comercial.

create or replace function public.save_payable_entry(
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
begin
  target_company := nullif(payload->>'companyId', '')::uuid;
  requested_amount := coalesce(nullif(payload->>'amount', '')::numeric, 0);
  requested_recurrence := coalesce(nullif(payload->>'recurrence', ''), 'once');

  if target_company is null then
    raise exception 'Empresa obrigatoria';
  end if;
  if not private.can_manage_finance(target_company) then
    raise exception 'Acesso negado';
  end if;
  if nullif(trim(payload->>'description'), '') is null then
    raise exception 'Descricao obrigatoria';
  end if;
  if requested_amount <= 0 then
    raise exception 'Valor deve ser positivo';
  end if;
  if nullif(payload->>'dueDate', '') is null then
    raise exception 'Vencimento obrigatorio';
  end if;
  if requested_recurrence not in ('once', 'weekly', 'monthly', 'quarterly', 'yearly', 'installment') then
    raise exception 'Recorrencia invalida';
  end if;

  if target_id is null then
    insert into public.payables(
      company_id,
      supplier_id,
      employee_id,
      description,
      amount,
      due_date,
      competence_date,
      category_id,
      cost_center_id,
      recurrence,
      installment_number,
      total_installments,
      parent_payable_id,
      status,
      proof_url,
      notes
    )
    values (
      target_company,
      nullif(payload->>'supplierId', '')::uuid,
      nullif(payload->>'employeeId', '')::uuid,
      trim(payload->>'description'),
      requested_amount,
      (payload->>'dueDate')::date,
      nullif(payload->>'competenceDate', '')::date,
      nullif(payload->>'categoryId', '')::uuid,
      nullif(payload->>'costCenterId', '')::uuid,
      requested_recurrence,
      nullif(payload->>'installmentNumber', '')::integer,
      nullif(payload->>'totalInstallments', '')::integer,
      nullif(payload->>'parentPayableId', '')::uuid,
      'open',
      nullif(payload->>'proofUrl', ''),
      nullif(payload->>'notes', '')
    )
    returning * into p;
  else
    select *
      into p
      from public.payables
     where id = target_id
     for update;

    if p.id is null or p.company_id <> target_company then
      raise exception 'Conta a pagar nao encontrada';
    end if;
    if p.paid_amount > 0
       or p.status in ('partial', 'paid')
       or exists (select 1 from public.settlements s where s.payable_id = p.id)
       or exists (select 1 from public.transactions t where t.payable_id = p.id) then
      raise exception 'Conta com pagamento nao pode ser editada; preserve o historico financeiro';
    end if;
    if exists (select 1 from public.commission_splits cs where cs.payable_id = p.id) then
      raise exception 'Conta vinculada a comissao deve ser ajustada no modulo de comissoes';
    end if;

    update public.payables
       set supplier_id = nullif(payload->>'supplierId', '')::uuid,
           employee_id = nullif(payload->>'employeeId', '')::uuid,
           description = trim(payload->>'description'),
           amount = requested_amount,
           due_date = (payload->>'dueDate')::date,
           competence_date = nullif(payload->>'competenceDate', '')::date,
           category_id = nullif(payload->>'categoryId', '')::uuid,
           cost_center_id = nullif(payload->>'costCenterId', '')::uuid,
           recurrence = requested_recurrence,
           proof_url = nullif(payload->>'proofUrl', ''),
           notes = nullif(payload->>'notes', ''),
           updated_at = now()
     where id = p.id
     returning * into p;
  end if;

  return p;
end;
$$;

create or replace function public.delete_payable_entry(target_id uuid)
returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  p public.payables;
begin
  select *
    into p
    from public.payables
   where id = target_id
   for update;

  if p.id is null then
    raise exception 'Conta a pagar nao encontrada';
  end if;
  if not private.can_manage_finance(p.company_id) then
    raise exception 'Acesso negado';
  end if;
  if p.paid_amount > 0
     or p.status in ('partial', 'paid')
     or exists (select 1 from public.settlements s where s.payable_id = p.id)
     or exists (select 1 from public.transactions t where t.payable_id = p.id) then
    raise exception 'Conta com pagamento nao pode ser excluida; estorne ou preserve o historico';
  end if;
  if exists (select 1 from public.commission_splits cs where cs.payable_id = p.id) then
    raise exception 'Conta vinculada a comissao nao pode ser excluida';
  end if;
  if exists (select 1 from public.payables child where child.parent_payable_id = p.id) then
    raise exception 'Conta com parcelas vinculadas nao pode ser excluida individualmente';
  end if;

  delete from public.payables where id = p.id;
  return p.id;
end;
$$;

create or replace function public.delete_receivable_entry(target_id uuid)
returns uuid
language plpgsql
security definer
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
  if r.received_amount > 0
     or r.status in ('partial', 'received')
     or exists (select 1 from public.settlements s where s.receivable_id = r.id)
     or exists (select 1 from public.transactions t where t.receivable_id = r.id) then
    raise exception 'Conta com recebimento nao pode ser excluida; estorne ou preserve o historico';
  end if;
  if exists (select 1 from public.invoices i where i.receivable_id = r.id) then
    raise exception 'Conta com NFS-e vinculada nao pode ser excluida';
  end if;
  if r.sale_id is not null
     or r.commission_installment_id is not null
     or exists (
       select 1
         from public.commission_installments ci
        where ci.receivable_id = r.id
     ) then
    raise exception 'Conta vinculada a venda ou comissao nao pode ser excluida';
  end if;

  delete from public.receivables where id = r.id;
  return r.id;
end;
$$;

revoke all on function public.save_payable_entry(uuid, jsonb) from public, anon;
revoke all on function public.delete_payable_entry(uuid) from public, anon;
revoke all on function public.delete_receivable_entry(uuid) from public, anon;

grant execute on function public.save_payable_entry(uuid, jsonb) to authenticated;
grant execute on function public.delete_payable_entry(uuid) to authenticated;
grant execute on function public.delete_receivable_entry(uuid) to authenticated;

-- Evita que um cliente contorne as validacoes chamando DELETE diretamente.
revoke delete on public.payables, public.receivables from authenticated;
