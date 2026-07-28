-- Endurece a exclusao segura sem expor funcoes SECURITY DEFINER na API.
-- As regras de integridade ficam em trigger e, portanto, tambem protegem
-- chamadas DELETE diretas que respeitem a RLS.

create or replace function private.guard_financial_account_delete()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  if tg_table_name = 'payables' then
    if old.paid_amount > 0
       or old.status in ('partial', 'paid')
       or exists (select 1 from public.settlements s where s.payable_id = old.id)
       or exists (select 1 from public.transactions t where t.payable_id = old.id) then
      raise exception 'Conta com pagamento nao pode ser excluida; estorne ou preserve o historico';
    end if;
    if exists (select 1 from public.commission_splits cs where cs.payable_id = old.id) then
      raise exception 'Conta vinculada a comissao nao pode ser excluida';
    end if;
    if exists (select 1 from public.payables child where child.parent_payable_id = old.id) then
      raise exception 'Conta com parcelas vinculadas nao pode ser excluida individualmente';
    end if;
  elsif tg_table_name = 'receivables' then
    if old.received_amount > 0
       or old.status in ('partial', 'received')
       or exists (select 1 from public.settlements s where s.receivable_id = old.id)
       or exists (select 1 from public.transactions t where t.receivable_id = old.id) then
      raise exception 'Conta com recebimento nao pode ser excluida; estorne ou preserve o historico';
    end if;
    if exists (select 1 from public.invoices i where i.receivable_id = old.id) then
      raise exception 'Conta com NFS-e vinculada nao pode ser excluida';
    end if;
    if old.sale_id is not null
       or old.commission_installment_id is not null
       or exists (
         select 1
           from public.commission_installments ci
          where ci.receivable_id = old.id
       ) then
      raise exception 'Conta vinculada a venda ou comissao nao pode ser excluida';
    end if;
  else
    raise exception 'Tabela financeira nao suportada';
  end if;

  return old;
end;
$$;

revoke all on function private.guard_financial_account_delete() from public, anon, authenticated;

drop trigger if exists guard_payable_delete on public.payables;
create trigger guard_payable_delete
  before delete on public.payables
  for each row execute function private.guard_financial_account_delete();

drop trigger if exists guard_receivable_delete on public.receivables;
create trigger guard_receivable_delete
  before delete on public.receivables
  for each row execute function private.guard_financial_account_delete();

create or replace function public.delete_payable_entry(target_id uuid)
returns uuid
language plpgsql
security invoker
set search_path = ''
as $$
declare
  deleted_id uuid;
begin
  delete from public.payables
   where id = target_id
   returning id into deleted_id;

  if deleted_id is null then
    raise exception 'Conta a pagar nao encontrada ou acesso negado';
  end if;

  return deleted_id;
end;
$$;

create or replace function public.delete_receivable_entry(target_id uuid)
returns uuid
language plpgsql
security invoker
set search_path = ''
as $$
declare
  deleted_id uuid;
begin
  delete from public.receivables
   where id = target_id
   returning id into deleted_id;

  if deleted_id is null then
    raise exception 'Conta a receber nao encontrada ou acesso negado';
  end if;

  return deleted_id;
end;
$$;

drop policy if exists payables_delete on public.payables;
create policy payables_delete on public.payables for delete to authenticated
  using (private.can_manage_finance(company_id));

drop policy if exists receivables_delete on public.receivables;
create policy receivables_delete on public.receivables for delete to authenticated
  using (private.can_manage_finance(company_id));

grant delete on public.payables, public.receivables to authenticated;
