-- O rollout inicial criou a constraint como NOT VALID para preservar a
-- disponibilidade. A auditoria confirmou que todos os registros existentes
-- satisfazem a regra; a validação torna a garantia integral no catálogo.
alter table public.receivables
  validate constraint receivables_cash_status_consistency;
