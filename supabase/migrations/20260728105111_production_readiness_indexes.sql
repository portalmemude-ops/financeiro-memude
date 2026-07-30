-- Preparação de produção: cobre todas as FKs das tabelas das Fases 0/1 e
-- remove índices simples duplicados introduzidos pelo baseline idempotente.

create index if not exists attachments_company_id_idx
  on public.attachments(company_id);
create index if not exists attachments_uploaded_by_idx
  on public.attachments(uploaded_by);

create index if not exists funnel_cards_broker_id_idx
  on public.funnel_cards(broker_id);
create index if not exists funnel_cards_development_id_idx
  on public.funnel_cards(development_id);
create index if not exists funnel_cards_sale_id_idx
  on public.funnel_cards(sale_id);

create index if not exists funnel_history_company_id_idx
  on public.funnel_history(company_id);
create index if not exists funnel_history_card_id_idx
  on public.funnel_history(card_id);
create index if not exists funnel_history_changed_by_idx
  on public.funnel_history(changed_by);

create index if not exists invoices_receivable_id_idx
  on public.invoices(receivable_id);
create index if not exists invoices_created_by_idx
  on public.invoices(created_by);

create index if not exists notification_rules_company_id_idx
  on public.notification_rules(company_id);
create index if not exists notifications_company_id_idx
  on public.notifications(company_id);

create index if not exists settlements_company_id_idx
  on public.settlements(company_id);
create index if not exists settlements_created_by_idx
  on public.settlements(created_by);
create index if not exists settlements_reversal_of_idx
  on public.settlements(reversal_of);

drop index if exists public.chart_accounts_company_idx;
drop index if exists public.clients_company_idx;
drop index if exists public.commissions_company_idx;
drop index if exists public.cost_centers_company_idx;
drop index if exists public.developments_company_idx;
drop index if exists public.employees_company_idx;
drop index if exists public.payables_company_idx;
drop index if exists public.receivables_company_idx;
drop index if exists public.sales_company_idx;
drop index if exists public.suppliers_company_idx;
drop index if exists public.transactions_company_idx;
