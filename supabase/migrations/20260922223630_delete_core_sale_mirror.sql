-- Remove somente o espelho de uma venda originada no MeMude Core.
-- Qualquer movimento financeiro associado interrompe a operacao. Contas a
-- Receber independentes (sale_id nulo) jamais participam desta exclusao.

create or replace function public.delete_core_sale_mirror(
  _core_venda_id uuid,
  _request_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = ''
as $$
declare
  sale_value public.sales;
  commissions_deleted integer := 0;
  funnel_cards_unlinked integer := 0;
begin
  if auth.role() <> 'service_role' then
    raise exception 'Acesso restrito ao servico de integracao' using errcode = '42501';
  end if;

  perform pg_catalog.pg_advisory_xact_lock(
    pg_catalog.hashtextextended(coalesce(_request_id::text, _core_venda_id::text), 0)
  );

  select s.*
    into sale_value
    from public.sales s
   where s.core_venda_id = _core_venda_id
     and s.source = 'memude_core'
   for update;

  if not found then
    return jsonb_build_object(
      'deleted', false,
      'already_deleted', true,
      'core_venda_id', _core_venda_id
    );
  end if;

  if exists (
    select 1 from public.receivables r where r.sale_id = sale_value.id
  ) then
    raise exception 'A venda possui Conta a Receber vinculada e nao pode ser excluida automaticamente.'
      using errcode = 'P0001';
  end if;

  if exists (
    select 1
      from public.commissions c
     where c.sale_id = sale_value.id
       and (c.source <> 'memude_core' or c.core_venda_id is distinct from _core_venda_id)
  ) then
    raise exception 'A venda possui comissao manual ou de outra origem e nao pode ser excluida automaticamente.'
      using errcode = 'P0001';
  end if;

  if exists (
    select 1
      from public.commission_installments ci
      join public.commissions c on c.id = ci.commission_id
     where c.sale_id = sale_value.id
  ) then
    raise exception 'A venda possui parcelas de comissao e nao pode ser excluida automaticamente.'
      using errcode = 'P0001';
  end if;

  if exists (
    select 1
      from public.commission_splits cs
      join public.commissions c on c.id = cs.commission_id
     where c.sale_id = sale_value.id
  ) then
    raise exception 'A venda possui repasses de comissao e nao pode ser excluida automaticamente.'
      using errcode = 'P0001';
  end if;

  update public.funnel_cards
     set sale_id = null,
         updated_at = now()
   where sale_id = sale_value.id;
  get diagnostics funnel_cards_unlinked = row_count;

  delete from public.commissions
   where sale_id = sale_value.id
     and source = 'memude_core'
     and core_venda_id = _core_venda_id;
  get diagnostics commissions_deleted = row_count;

  delete from public.sales
   where id = sale_value.id
     and source = 'memude_core';

  return jsonb_build_object(
    'deleted', true,
    'already_deleted', false,
    'core_venda_id', _core_venda_id,
    'finance_sale_id', sale_value.id,
    'commissions_deleted', commissions_deleted,
    'funnel_cards_unlinked', funnel_cards_unlinked
  );
end;
$$;

revoke all on function public.delete_core_sale_mirror(uuid, uuid) from public, anon, authenticated;
grant execute on function public.delete_core_sale_mirror(uuid, uuid) to service_role;
