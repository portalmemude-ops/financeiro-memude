create index if not exists auth_invitations_requested_by_idx
  on public.auth_invitations(requested_by);
create index if not exists chart_accounts_company_id_idx
  on public.chart_accounts(company_id);
create index if not exists commission_installments_commission_id_idx
  on public.commission_installments(commission_id);
create index if not exists cost_centers_company_id_idx
  on public.cost_centers(company_id);
create index if not exists integration_conflicts_resolved_by_idx
  on public.integration_conflicts(resolved_by);
create index if not exists receivables_sale_id_idx
  on public.receivables(sale_id);
