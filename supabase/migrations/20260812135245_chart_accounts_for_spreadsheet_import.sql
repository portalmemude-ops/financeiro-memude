-- Contas do plano necessárias para receber a planilha de fluxo de caixa.
insert into public.chart_accounts (company_id, parent_id, code, name, type, is_active)
select c.company_id, c.parent_id, c.code, c.name, c.type, true
from (
  values
    ('5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6'::uuid,
     (select id from public.chart_accounts where company_id='5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6' and code='1'),
     '1.3','Aportes de sócios','revenue'),
    ('5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6'::uuid,
     (select id from public.chart_accounts where company_id='5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6' and code='2'),
     '2.5','Pessoal e RH','expense'),
    ('5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6'::uuid,
     (select id from public.chart_accounts where company_id='5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6' and code='2'),
     '2.6','Despesas financeiras','expense')
) as c(company_id, parent_id, code, name, type)
where not exists (
  select 1 from public.chart_accounts x
  where x.company_id = c.company_id and x.code = c.code
);
