-- ===========================================================================
-- Importa a planilha "MeMude - Fluxo de Caixa" para o modelo financeiro.
-- Cada linha vira a cadeia completa: conta (paga/recebida) -> liquidação ->
-- lançamento no caixa. Tudo marcado com [PLANILHA#n] para permitir reversão.
--
-- Depende dos dados carregados em public.import_planilha_caixa. Numa base sem
-- essa carga o bloco simplesmente não cria nada.
-- ===========================================================================
do $$
declare
  v_company uuid := '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6';
  v_user    uuid := '8122a75c-e60a-4630-80b3-07915cd49ef2';
begin

if exists (select 1 from public.payables  where notes like '%[PLANILHA#%')
or exists (select 1 from public.receivables where notes like '%[PLANILHA#%') then
  raise exception 'A planilha já foi importada. Reverta antes de importar de novo.';
end if;

-- ---------------------------------------------------------------- mapeamento
create temp table map_row on commit drop as
select
  s.*,
  (s.descricao ~* '(aporte|adiantamento\s+(de\s+)?s[óo]cio)') as eh_aporte,
  (s.descricao ~* 'comiss')                                   as eh_comissao
from public.import_planilha_caixa s;

create temp table map_conta on commit drop as
select
  r.idx,
  case
    when r.tipo = 'Entrada' then
      case when r.eh_aporte   then (select id from public.chart_accounts where company_id=v_company and code='1.3')
           when r.eh_comissao then (select id from public.chart_accounts where company_id=v_company and code='1.1')
           else                    (select id from public.chart_accounts where company_id=v_company and code='1.2') end
    else
      case r.centro_custo
        when 'Comissão'              then (select id from public.chart_accounts where company_id=v_company and code='2.1')
        when 'Marketing'             then (select id from public.chart_accounts where company_id=v_company and code='2.3')
        when 'CONECTA CORRETORES'    then (select id from public.chart_accounts where company_id=v_company and code='2.3')
        when 'Recursos Humanos (RH)' then (select id from public.chart_accounts where company_id=v_company and code='2.5')
        when 'Financeiro'            then (select id from public.chart_accounts where company_id=v_company and code='2.6')
        else                              (select id from public.chart_accounts where company_id=v_company and code='2.2')
      end
  end as category_id,
  case
    when r.tipo = 'Entrada' then
      case when r.eh_aporte   then (select id from public.cost_centers where company_id=v_company and name='Administrativo')
           when r.eh_comissao then (select id from public.cost_centers where company_id=v_company and name='Comercial')
           when r.centro_custo in ('Marketing','Operacional')
                              then (select id from public.cost_centers where company_id=v_company and name='Marketing e Tecnologia')
           else                    (select id from public.cost_centers where company_id=v_company and name='Administrativo') end
    else
      case
        when r.centro_custo in ('Comissão','Comercial')
             then (select id from public.cost_centers where company_id=v_company and name='Comercial')
        when r.centro_custo in ('Marketing','CONECTA CORRETORES')
             then (select id from public.cost_centers where company_id=v_company and name='Marketing e Tecnologia')
        else (select id from public.cost_centers where company_id=v_company and name='Administrativo')
      end
  end as cost_center_id
from map_row r;

-- ------------------------------------------------------------------ ENTRADAS
create temp table novo_receb on commit drop as
with ins as (
  insert into public.receivables (
    company_id, client_name, description, amount, due_date, competence_date,
    category_id, cost_center_id, invoice_rule, recurrence, status,
    account, received_at, received_amount, notes, created_at, updated_at
  )
  select
    v_company,
    case when r.responsavel in ('SÉRGIO','RENO') then 'Sócio ' || initcap(lower(r.responsavel))
         else 'Não informado' end,
    r.descricao,
    r.valor,
    coalesce(r.vencimento, r.data),
    r.data,
    m.category_id,
    m.cost_center_id,
    'none',
    'once',
    'received',
    r.conta,
    r.data::timestamptz,
    r.valor,
    format('[PLANILHA#%s] Centro planilha: %s. Responsável: %s.%s',
           r.idx, coalesce(r.centro_custo,'—'), coalesce(r.responsavel,'—'),
           case when r.comprovante is null then '' else ' Comprovante: '||r.comprovante end),
    r.data::timestamptz,
    r.data::timestamptz
  from map_row r join map_conta m using (idx)
  where r.tipo = 'Entrada'
  returning id, notes, amount, account, description, category_id, cost_center_id
)
select ins.*, (regexp_match(ins.notes, '\[PLANILHA#(\d+)\]'))[1]::int as idx from ins;

-- ------------------------------------------------------------------- SAÍDAS
create temp table novo_pagar on commit drop as
with ins as (
  insert into public.payables (
    company_id, description, amount, due_date, competence_date,
    category_id, cost_center_id, recurrence, status,
    payment_method, account, paid_at, paid_amount, notes, created_at, updated_at
  )
  select
    v_company,
    r.descricao,
    r.valor,
    coalesce(r.vencimento, r.data),
    r.data,
    m.category_id,
    m.cost_center_id,
    'once',
    'paid',
    'transfer',
    r.conta,
    r.data::timestamptz,
    r.valor,
    format('[PLANILHA#%s] Centro planilha: %s. Responsável: %s.%s%s',
           r.idx, coalesce(r.centro_custo,'—'), coalesce(r.responsavel,'—'),
           case when r.comprovante is null then '' else ' Comprovante: '||r.comprovante end,
           case when r.tipo = 'Saída (Outra conta)' then ' [Saída por outra conta]' else '' end),
    r.data::timestamptz,
    r.data::timestamptz
  from map_row r join map_conta m using (idx)
  where r.tipo like 'Saída%'
  returning id, notes, amount, account, description, category_id, cost_center_id
)
select ins.*, (regexp_match(ins.notes, '\[PLANILHA#(\d+)\]'))[1]::int as idx from ins;

-- -------------------------------------------------------------- LIQUIDAÇÕES
create temp table novo_liq on commit drop as
with ins as (
  insert into public.settlements (
    company_id, receivable_id, payable_id, type, amount, settled_at,
    payment_method, account, request_id, notes, created_by, created_at
  )
  select v_company, n.id, null, 'receipt', n.amount, r.data::timestamptz,
         'transfer', n.account, md5('planilha-receb-'||n.idx)::uuid,
         format('[PLANILHA#%s] Recebimento importado da planilha.', n.idx),
         v_user, r.data::timestamptz
  from novo_receb n join map_row r using (idx)
  union all
  select v_company, null, n.id, 'payment', n.amount, r.data::timestamptz,
         'transfer', n.account, md5('planilha-pagar-'||n.idx)::uuid,
         format('[PLANILHA#%s] Pagamento importado da planilha.', n.idx),
         v_user, r.data::timestamptz
  from novo_pagar n join map_row r using (idx)
  returning id, receivable_id, payable_id, notes
)
select ins.*, (regexp_match(ins.notes, '\[PLANILHA#(\d+)\]'))[1]::int as idx from ins;

-- -------------------------------------------------------------- LANÇAMENTOS
insert into public.transactions (
  company_id, type, amount, date, description, account,
  category_id, cost_center_id, receivable_id, payable_id, settlement_id, created_at
)
select v_company, 'income', n.amount, r.data, n.description, n.account,
       n.category_id, n.cost_center_id, n.id, null, l.id, r.data::timestamptz
from novo_receb n
join map_row r using (idx)
join novo_liq l on l.receivable_id = n.id
union all
select v_company, 'expense', n.amount, r.data, n.description, n.account,
       n.category_id, n.cost_center_id, null, n.id, l.id, r.data::timestamptz
from novo_pagar n
join map_row r using (idx)
join novo_liq l on l.payable_id = n.id;

end $$;
