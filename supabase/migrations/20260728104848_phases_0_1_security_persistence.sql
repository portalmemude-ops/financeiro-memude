-- Fases 0 e 1: contenção, autorização real, persistência e auditabilidade.
-- Migração aditiva; não remove dados financeiros existentes.

create schema if not exists private;
revoke all on schema private from public, anon, authenticated;

-- Compatibilidade entre o domínio da aplicação e o schema real.
alter table public.chart_accounts add column if not exists is_active boolean not null default true;
alter table public.cost_centers add column if not exists is_active boolean not null default true;
alter table public.payables add column if not exists paid_amount numeric(18,2) not null default 0;
alter table public.receivables add column if not exists received_amount numeric(18,2) not null default 0;
alter table public.payables add column if not exists updated_at timestamptz not null default now();
alter table public.receivables add column if not exists updated_at timestamptz not null default now();

-- Preserva a semântica dos registros já liquidados antes da criação dos saldos.
update public.payables
   set paid_amount = amount
 where status = 'paid' and paid_amount = 0;
update public.receivables
   set received_amount = amount
 where status = 'received' and received_amount = 0;

alter table public.payables drop constraint if exists payables_status_check;
alter table public.payables add constraint payables_status_check
  check (status in ('open', 'partial', 'paid', 'overdue', 'cancelled'));
alter table public.receivables drop constraint if exists receivables_status_check;
alter table public.receivables add constraint receivables_status_check
  check (status in ('open', 'partial', 'received', 'overdue', 'cancelled'));
alter table public.payables drop constraint if exists payables_recurrence_check;
alter table public.payables add constraint payables_recurrence_check
  check (recurrence in ('once', 'weekly', 'monthly', 'quarterly', 'yearly', 'installment'));
alter table public.receivables drop constraint if exists receivables_recurrence_check;
alter table public.receivables add constraint receivables_recurrence_check
  check (recurrence in ('once', 'weekly', 'monthly', 'quarterly', 'yearly'));
alter table public.receivables drop constraint if exists receivables_invoice_rule_check;
alter table public.receivables add constraint receivables_invoice_rule_check
  check (invoice_rule in ('immediate', 'on_receive', 'scheduled', 'recurring', 'manual', 'none'));
alter table public.employees drop constraint if exists employees_employment_type_check;
alter table public.employees add constraint employees_employment_type_check
  check (employment_type in ('clt', 'pj', 'freelancer', 'commission_only', 'intern'));
alter table public.employees drop constraint if exists employees_status_check;
alter table public.employees add constraint employees_status_check
  check (status in ('active', 'inactive', 'terminated'));
alter table public.chart_accounts drop constraint if exists chart_accounts_type_check;
alter table public.chart_accounts add constraint chart_accounts_type_check
  check (type in ('asset', 'liability', 'revenue', 'expense'));

alter table public.payables drop constraint if exists payables_amount_positive;
alter table public.payables add constraint payables_amount_positive check (amount > 0);
alter table public.payables drop constraint if exists payables_paid_amount_valid;
alter table public.payables add constraint payables_paid_amount_valid check (paid_amount >= 0 and paid_amount <= amount);
alter table public.receivables drop constraint if exists receivables_amount_positive;
alter table public.receivables add constraint receivables_amount_positive check (amount > 0);
alter table public.receivables drop constraint if exists receivables_received_amount_valid;
alter table public.receivables add constraint receivables_received_amount_valid check (received_amount >= 0 and received_amount <= amount);
alter table public.transactions drop constraint if exists transactions_amount_positive;
alter table public.transactions add constraint transactions_amount_positive check (amount > 0);
alter table public.sales drop constraint if exists sales_value_positive;
-- Há registros legados com valor zero; bloqueia novos casos sem invalidar o rollout.
alter table public.sales add constraint sales_value_positive check (sale_value > 0) not valid;
alter table public.developments drop constraint if exists developments_commission_percentage_valid;
alter table public.developments add constraint developments_commission_percentage_valid
  check (commission_percentage is null or commission_percentage between 0 and 100);
alter table public.developments drop constraint if exists developments_broker_split_valid;
alter table public.developments add constraint developments_broker_split_valid
  check (broker_split_percentage is null or broker_split_percentage between 0 and 100);
alter table public.commission_splits drop constraint if exists commission_splits_percentage_valid;
alter table public.commission_splits add constraint commission_splits_percentage_valid
  check (percentage is null or percentage between 0 and 100);
alter table public.commission_splits drop constraint if exists commission_splits_amount_valid;
alter table public.commission_splits add constraint commission_splits_amount_valid check (amount >= 0);
alter table public.commission_splits drop constraint if exists commission_splits_beneficiary_type_check;
alter table public.commission_splits add constraint commission_splits_beneficiary_type_check
  check (beneficiary_type in ('brokerage', 'broker', 'manager', 'captador'));
alter table public.commission_splits drop constraint if exists commission_splits_status_check;
alter table public.commission_splits add constraint commission_splits_status_check
  check (status in ('pending', 'paid', 'not_applicable'));
alter table public.commissions drop constraint if exists commissions_status_check;
alter table public.commissions add constraint commissions_status_check
  check (status in ('pending', 'partial', 'received', 'cancelled'));

create unique index if not exists suppliers_company_document_uidx
  on public.suppliers(company_id, document) where document is not null and document <> '';
create unique index if not exists clients_company_document_uidx
  on public.clients(company_id, document) where document is not null and document <> '';
create unique index if not exists employees_company_document_uidx
  on public.employees(company_id, document) where document is not null and document <> '';
create index if not exists payables_company_status_due_idx on public.payables(company_id, status, due_date);
create index if not exists receivables_company_status_due_idx on public.receivables(company_id, status, due_date);
create index if not exists transactions_company_date_idx on public.transactions(company_id, date desc);
create index if not exists sales_company_date_idx on public.sales(company_id, sale_date desc);
create index if not exists payables_supplier_idx on public.payables(supplier_id);
create index if not exists payables_employee_idx on public.payables(employee_id);
create index if not exists payables_category_idx on public.payables(category_id);
create index if not exists payables_cost_center_idx on public.payables(cost_center_id);
create index if not exists payables_parent_idx on public.payables(parent_payable_id);
create index if not exists receivables_category_idx on public.receivables(category_id);
create index if not exists receivables_cost_center_idx on public.receivables(cost_center_id);
create index if not exists chart_accounts_parent_idx on public.chart_accounts(parent_id);
create index if not exists employees_user_idx on public.employees(user_id);
create unique index if not exists commissions_sale_uidx on public.commissions(sale_id);
create index if not exists commission_installments_receivable_idx on public.commission_installments(receivable_id);
create index if not exists commission_splits_beneficiary_idx on public.commission_splits(beneficiary_id);
create index if not exists commission_splits_payable_idx on public.commission_splits(payable_id);
create index if not exists sales_development_idx on public.sales(development_id);
create index if not exists sales_broker_idx on public.sales(broker_id);
create index if not exists transactions_category_idx on public.transactions(category_id);
create index if not exists transactions_cost_center_idx on public.transactions(cost_center_id);
create index if not exists transactions_payable_idx on public.transactions(payable_id);
create index if not exists transactions_receivable_idx on public.transactions(receivable_id);

-- Remove a função administrativa exposta indevidamente pela API do projeto legado.
do $$
begin
  if to_regprocedure('public.rls_auto_enable()') is not null then
    execute 'revoke all on function public.rls_auto_enable() from public, anon, authenticated';
  end if;
end $$;

-- Dados que existiam somente no Pinia.
create table if not exists public.funnel_cards (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  contact_name text not null,
  contact_phone text,
  contact_email text,
  development_id uuid references public.developments(id),
  estimated_value numeric(18,2) not null default 0 check (estimated_value >= 0),
  broker_id uuid references public.employees(id),
  current_stage text not null check (current_stage in ('lead', 'visit', 'proposal', 'contract', 'deed')),
  sale_id uuid references public.sales(id),
  notes text,
  stage_entered_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.funnel_history (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  card_id uuid not null references public.funnel_cards(id) on delete cascade,
  from_stage text,
  to_stage text not null,
  changed_by uuid references auth.users(id),
  changed_at timestamptz not null default now()
);

create table if not exists public.invoices (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  receivable_id uuid references public.receivables(id),
  status text not null default 'pending'
    check (status in ('pending', 'processing', 'issued', 'cancelled', 'error', 'simulated')),
  environment text not null default 'homologacao' check (environment in ('homologacao', 'producao')),
  provider text not null default 'ginfes',
  rps_number bigint,
  rps_series text not null default '1',
  nfse_number text,
  verification_code text,
  protocol text,
  service_code text,
  service_description text not null,
  amount numeric(18,2) not null check (amount > 0),
  iss_rate numeric(7,4) not null default 0 check (iss_rate between 0 and 100),
  taker_name text not null,
  taker_document text not null,
  taker_email text,
  xml_request text,
  xml_response text,
  pdf_url text,
  error_message text,
  issued_at timestamptz,
  cancelled_at timestamptz,
  created_by uuid references auth.users(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(company_id, environment, rps_series, rps_number)
);

create table if not exists public.fiscal_sequences (
  company_id uuid not null references public.companies(id) on delete cascade,
  environment text not null check (environment in ('homologacao', 'producao')),
  series text not null,
  last_number bigint not null default 0 check (last_number >= 0),
  updated_at timestamptz not null default now(),
  primary key(company_id, environment, series)
);

create table if not exists public.notifications (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  user_id uuid references auth.users(id) on delete cascade,
  type text not null,
  title text not null,
  message text not null,
  status text not null default 'pending' check (status in ('pending', 'sent', 'read', 'failed')),
  metadata jsonb not null default '{}'::jsonb,
  sent_at timestamptz,
  read_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.notification_rules (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  type text not null,
  name text not null,
  is_active boolean not null default true,
  channels text[] not null default '{}',
  days_before integer not null default 0,
  config jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.attachments (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  entity_type text not null,
  entity_id uuid not null,
  bucket_id text not null default 'financial-attachments',
  object_path text not null unique,
  original_name text not null,
  mime_type text not null,
  size_bytes bigint not null check (size_bytes > 0 and size_bytes <= 10485760),
  sha256 text,
  uploaded_by uuid not null references auth.users(id),
  created_at timestamptz not null default now()
);

create table if not exists public.audit_log (
  id bigint generated always as identity primary key,
  company_id uuid,
  actor_id uuid,
  action text not null,
  entity_type text not null,
  entity_id text,
  old_data jsonb,
  new_data jsonb,
  request_id text,
  created_at timestamptz not null default now()
);

create table if not exists public.settlements (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  payable_id uuid references public.payables(id),
  receivable_id uuid references public.receivables(id),
  type text not null check (type in ('payment', 'receipt', 'reversal')),
  amount numeric(18,2) not null check (amount > 0),
  settled_at timestamptz not null,
  payment_method text,
  account text,
  proof_url text,
  reversal_of uuid references public.settlements(id),
  created_by uuid not null references auth.users(id),
  created_at timestamptz not null default now(),
  check (
    (payable_id is not null and receivable_id is null and type in ('payment', 'reversal'))
    or (payable_id is null and receivable_id is not null and type in ('receipt', 'reversal'))
  )
);

create index if not exists funnel_cards_company_stage_idx on public.funnel_cards(company_id, current_stage);
create index if not exists invoices_company_status_idx on public.invoices(company_id, status, created_at desc);
create index if not exists notifications_user_status_idx on public.notifications(user_id, status, created_at desc);
create index if not exists audit_log_company_created_idx on public.audit_log(company_id, created_at desc);
create index if not exists settlements_payable_idx on public.settlements(payable_id, created_at);
create index if not exists settlements_receivable_idx on public.settlements(receivable_id, created_at);

-- Helpers de autorização ficam fora do schema exposto. SECURITY DEFINER é
-- necessário para evitar recursão na RLS de company_members; search_path,
-- grants e auth.uid() são restringidos explicitamente.
create or replace function private.has_company_role(target_company uuid, allowed_roles text[])
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select (select auth.uid()) is not null and exists (
    select 1
      from public.company_members cm
     where cm.company_id = target_company
       and cm.user_id = (select auth.uid())
       and cm.role = any(allowed_roles)
  );
$$;

create or replace function private.is_company_member(target_company uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select private.has_company_role(
    target_company,
    array['super_admin','admin','financial','broker','accountant','viewer']
  );
$$;

create or replace function private.can_manage_finance(target_company uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select private.has_company_role(target_company, array['super_admin','admin','financial']);
$$;

create or replace function private.can_admin_company(target_company uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select private.has_company_role(target_company, array['super_admin','admin']);
$$;

revoke all on all functions in schema private from public, anon;
grant usage on schema private to authenticated;
grant execute on function private.has_company_role(uuid, text[]) to authenticated;
grant execute on function private.is_company_member(uuid) to authenticated;
grant execute on function private.can_manage_finance(uuid) to authenticated;
grant execute on function private.can_admin_company(uuid) to authenticated;

-- Substitui o trigger legado que concedia super_admin por e-mail hardcoded.
create or replace function private.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.user_profiles(id, full_name, email)
  values (new.id, nullif(new.raw_user_meta_data->>'full_name', ''), new.email)
  on conflict (id) do update
    set full_name = coalesce(excluded.full_name, public.user_profiles.full_name),
        email = excluded.email;
  return new;
end;
$$;
revoke all on function private.handle_new_user() from public, anon, authenticated;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert or update of email, raw_user_meta_data on auth.users
  for each row execute function private.handle_new_user();

create or replace function public.my_memberships()
returns table(company_id uuid, role text)
language sql
stable
security invoker
set search_path = ''
as $$
  select cm.company_id, cm.role
    from public.company_members cm
   where cm.user_id = (select auth.uid());
$$;
revoke all on function public.my_memberships() from public, anon;
grant execute on function public.my_memberships() to authenticated;

-- Remove as políticas permissivas antigas.
do $$
declare p record;
begin
  for p in
    select schemaname, tablename, policyname
      from pg_policies
     where schemaname = 'public'
       and tablename in (
         'companies','company_members','user_profiles','chart_accounts','cost_centers',
         'suppliers','clients','employees','payables','receivables','transactions',
         'developments','sales','commissions','commission_installments','commission_splits',
         'funnel_cards','funnel_history','invoices','fiscal_sequences','notifications',
         'notification_rules','attachments','audit_log','settlements'
       )
  loop
    execute format('drop policy if exists %I on %I.%I', p.policyname, p.schemaname, p.tablename);
  end loop;
end $$;

-- Perfil e vínculos.
alter table public.companies enable row level security;
create policy companies_select on public.companies for select to authenticated
  using (private.is_company_member(id));
create policy companies_update on public.companies for update to authenticated
  using (private.can_admin_company(id)) with check (private.can_admin_company(id));

alter table public.company_members enable row level security;
create policy members_select on public.company_members for select to authenticated
  using (user_id = (select auth.uid()) or private.can_admin_company(company_id));
create policy members_insert on public.company_members for insert to authenticated
  with check (private.can_admin_company(company_id));
create policy members_update on public.company_members for update to authenticated
  using (private.can_admin_company(company_id)) with check (private.can_admin_company(company_id));
create policy members_delete on public.company_members for delete to authenticated
  using (private.can_admin_company(company_id) and user_id <> (select auth.uid()));

alter table public.user_profiles enable row level security;
create policy profiles_select on public.user_profiles for select to authenticated
  using (
    id = (select auth.uid()) or exists (
      select 1 from public.company_members mine
      join public.company_members theirs on theirs.company_id = mine.company_id
      where mine.user_id = (select auth.uid()) and theirs.user_id = user_profiles.id
    )
  );
create policy profiles_insert on public.user_profiles for insert to authenticated
  with check (id = (select auth.uid()));
create policy profiles_update on public.user_profiles for update to authenticated
  using (id = (select auth.uid())) with check (id = (select auth.uid()));

-- Tabelas de negócio com company_id: todos os membros leem; apenas
-- super_admin/admin/financial escrevem; exclusão fica limitada a admins.
do $$
declare t text;
begin
  foreach t in array array[
    'chart_accounts','cost_centers','suppliers','clients','employees','payables',
    'receivables','transactions','developments','commissions',
    'invoices','fiscal_sequences','notification_rules',
    'attachments','settlements'
  ]
  loop
    execute format('alter table public.%I enable row level security', t);
    execute format(
      'create policy %I on public.%I for select to authenticated using (private.is_company_member(company_id))',
      t || '_select', t
    );
    execute format(
      'create policy %I on public.%I for insert to authenticated with check (private.can_manage_finance(company_id))',
      t || '_insert', t
    );
    execute format(
      'create policy %I on public.%I for update to authenticated using (private.can_manage_finance(company_id)) with check (private.can_manage_finance(company_id))',
      t || '_update', t
    );
    execute format(
      'create policy %I on public.%I for delete to authenticated using (private.can_admin_company(company_id))',
      t || '_delete', t
    );
  end loop;
end $$;

-- Funil: gestores operam tudo; corretor opera apenas cards próprios.
alter table public.funnel_cards enable row level security;
create policy funnel_cards_select on public.funnel_cards for select to authenticated
  using (
    private.can_manage_finance(company_id)
    or private.has_company_role(company_id, array['accountant','viewer'])
    or exists (
      select 1 from public.employees e
       where e.id = broker_id and e.company_id = funnel_cards.company_id
         and e.user_id = (select auth.uid())
    )
  );
create policy funnel_cards_insert on public.funnel_cards for insert to authenticated
  with check (
    private.can_manage_finance(company_id)
    or exists (
      select 1 from public.employees e
       where e.id = broker_id and e.company_id = funnel_cards.company_id
         and e.user_id = (select auth.uid())
         and private.has_company_role(company_id, array['broker'])
    )
  );
create policy funnel_cards_update on public.funnel_cards for update to authenticated
  using (
    private.can_manage_finance(company_id)
    or exists (
      select 1 from public.employees e
       where e.id = broker_id and e.company_id = funnel_cards.company_id
         and e.user_id = (select auth.uid())
    )
  )
  with check (
    private.can_manage_finance(company_id)
    or exists (
      select 1 from public.employees e
       where e.id = broker_id and e.company_id = funnel_cards.company_id
         and e.user_id = (select auth.uid())
    )
  );
create policy funnel_cards_delete on public.funnel_cards for delete to authenticated
  using (private.can_admin_company(company_id));

alter table public.funnel_history enable row level security;
create policy funnel_history_select on public.funnel_history for select to authenticated
  using (private.is_company_member(company_id));
create policy funnel_history_insert on public.funnel_history for insert to authenticated
  with check (
    private.can_manage_finance(company_id)
    or exists (
      select 1 from public.funnel_cards fc
      join public.employees e on e.id = fc.broker_id
       where fc.id = card_id and fc.company_id = funnel_history.company_id
         and e.user_id = (select auth.uid())
    )
  );

-- Corretor pode registrar/editar somente vendas vinculadas ao seu funcionário.
alter table public.sales enable row level security;
create policy sales_select on public.sales for select to authenticated
  using (private.is_company_member(company_id));
create policy sales_insert on public.sales for insert to authenticated
  with check (
    private.can_manage_finance(company_id)
    or exists (
      select 1 from public.employees e
       where e.id = broker_id and e.company_id = sales.company_id
         and e.user_id = (select auth.uid())
         and private.has_company_role(company_id, array['broker'])
    )
  );
create policy sales_update on public.sales for update to authenticated
  using (
    private.can_manage_finance(company_id)
    or exists (
      select 1 from public.employees e
       where e.id = broker_id and e.company_id = sales.company_id
         and e.user_id = (select auth.uid())
         and private.has_company_role(company_id, array['broker'])
    )
  )
  with check (
    private.can_manage_finance(company_id)
    or exists (
      select 1 from public.employees e
       where e.id = broker_id and e.company_id = sales.company_id
         and e.user_id = (select auth.uid())
         and private.has_company_role(company_id, array['broker'])
    )
  );
create policy sales_delete on public.sales for delete to authenticated
  using (private.can_admin_company(company_id));

-- Filhas de comissão não possuem company_id.
alter table public.commission_installments enable row level security;
create policy commission_installments_select on public.commission_installments for select to authenticated
  using (exists (
    select 1 from public.commissions c
     where c.id = commission_id and private.is_company_member(c.company_id)
  ));
create policy commission_installments_insert on public.commission_installments for insert to authenticated
  with check (exists (
    select 1 from public.commissions c
     where c.id = commission_id and private.can_manage_finance(c.company_id)
  ));
create policy commission_installments_update on public.commission_installments for update to authenticated
  using (exists (
    select 1 from public.commissions c
     where c.id = commission_id and private.can_manage_finance(c.company_id)
  ))
  with check (exists (
    select 1 from public.commissions c
     where c.id = commission_id and private.can_manage_finance(c.company_id)
  ));
create policy commission_installments_delete on public.commission_installments for delete to authenticated
  using (exists (
    select 1 from public.commissions c
     where c.id = commission_id and private.can_admin_company(c.company_id)
  ));

alter table public.commission_splits enable row level security;
create policy commission_splits_select on public.commission_splits for select to authenticated
  using (exists (
    select 1 from public.commissions c
     where c.id = commission_id and private.is_company_member(c.company_id)
  ));
create policy commission_splits_insert on public.commission_splits for insert to authenticated
  with check (exists (
    select 1 from public.commissions c
     where c.id = commission_id and private.can_manage_finance(c.company_id)
  ));
create policy commission_splits_update on public.commission_splits for update to authenticated
  using (exists (
    select 1 from public.commissions c
     where c.id = commission_id and private.can_manage_finance(c.company_id)
  ))
  with check (exists (
    select 1 from public.commissions c
     where c.id = commission_id and private.can_manage_finance(c.company_id)
  ));
create policy commission_splits_delete on public.commission_splits for delete to authenticated
  using (exists (
    select 1 from public.commissions c
     where c.id = commission_id and private.can_admin_company(c.company_id)
  ));

alter table public.notifications enable row level security;
create policy notifications_select on public.notifications for select to authenticated
  using (private.is_company_member(company_id) and (user_id is null or user_id = (select auth.uid())));
create policy notifications_update on public.notifications for update to authenticated
  using (private.is_company_member(company_id) and user_id = (select auth.uid()))
  with check (private.is_company_member(company_id) and user_id = (select auth.uid()));

alter table public.audit_log enable row level security;
create policy audit_log_select on public.audit_log for select to authenticated
  using (private.has_company_role(company_id, array['super_admin','admin','accountant']));

-- Liquidação atômica: cria settlement, transaction e atualiza o saldo.
create or replace function public.settle_payable(
  target_id uuid,
  settle_amount numeric,
  settle_at timestamptz default now(),
  method text default null,
  account_name text default null,
  proof text default null
) returns public.payables
language plpgsql
security invoker
set search_path = ''
as $$
declare p public.payables;
declare remaining numeric;
begin
  select * into p from public.payables where id = target_id for update;
  if p.id is null then raise exception 'Conta a pagar não encontrada'; end if;
  if not private.can_manage_finance(p.company_id) then raise exception 'Acesso negado'; end if;
  if p.status = 'cancelled' then raise exception 'Conta cancelada não pode ser paga'; end if;
  remaining := p.amount - p.paid_amount;
  if settle_amount <= 0 or settle_amount > remaining then raise exception 'Valor de pagamento inválido'; end if;

  insert into public.settlements(company_id, payable_id, type, amount, settled_at, payment_method, account, proof_url, created_by)
  values (p.company_id, p.id, 'payment', settle_amount, settle_at, method, account_name, proof, (select auth.uid()));
  insert into public.transactions(company_id, type, amount, date, description, account, category_id, cost_center_id, payable_id)
  values (p.company_id, 'expense', settle_amount, settle_at::date, p.description, account_name, p.category_id, p.cost_center_id, p.id);
  update public.payables
     set paid_amount = paid_amount + settle_amount,
         paid_at = case when paid_amount + settle_amount = amount then settle_at else paid_at end,
         payment_method = coalesce(method, payment_method),
         account = coalesce(account_name, account),
         proof_url = coalesce(proof, proof_url),
         status = case when paid_amount + settle_amount = amount then 'paid' else 'partial' end,
         updated_at = now()
   where id = p.id
   returning * into p;
  if p.status = 'paid' then
    update public.commission_splits
       set status = 'paid'
     where payable_id = p.id and status = 'pending';
  end if;
  return p;
end;
$$;

create or replace function public.settle_receivable(
  target_id uuid,
  settle_amount numeric,
  settle_at timestamptz default now(),
  method text default null,
  account_name text default null,
  proof text default null
) returns public.receivables
language plpgsql
security invoker
set search_path = ''
as $$
declare r public.receivables;
declare remaining numeric;
begin
  select * into r from public.receivables where id = target_id for update;
  if r.id is null then raise exception 'Conta a receber não encontrada'; end if;
  if not private.can_manage_finance(r.company_id) then raise exception 'Acesso negado'; end if;
  if r.status = 'cancelled' then raise exception 'Conta cancelada não pode ser recebida'; end if;
  remaining := r.amount - r.received_amount;
  if settle_amount <= 0 or settle_amount > remaining then raise exception 'Valor de recebimento inválido'; end if;

  insert into public.settlements(company_id, receivable_id, type, amount, settled_at, payment_method, account, proof_url, created_by)
  values (r.company_id, r.id, 'receipt', settle_amount, settle_at, method, account_name, proof, (select auth.uid()));
  insert into public.transactions(company_id, type, amount, date, description, account, category_id, cost_center_id, receivable_id)
  values (r.company_id, 'income', settle_amount, settle_at::date, r.description, account_name, r.category_id, r.cost_center_id, r.id);
  update public.receivables
     set received_amount = received_amount + settle_amount,
         received_at = case when received_amount + settle_amount = amount then settle_at else received_at end,
         account = coalesce(account_name, account),
         proof_url = coalesce(proof, proof_url),
         status = case when received_amount + settle_amount = amount then 'received' else 'partial' end,
         updated_at = now()
   where id = r.id
   returning * into r;
  if r.status = 'received' and r.commission_installment_id is not null then
    update public.commission_installments
       set status = 'received', received_date = settle_at::date
     where id = r.commission_installment_id;
    update public.commissions c
       set status = case
         when not exists (
           select 1 from public.commission_installments ci
            where ci.commission_id = c.id and ci.status <> 'received'
         ) then 'received'
         when exists (
           select 1 from public.commission_installments ci
            where ci.commission_id = c.id and ci.status = 'received'
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

-- Movimento de funil e histórico formam uma única operação.
create or replace function public.move_funnel_card(
  target_id uuid,
  target_stage text
) returns public.funnel_cards
language plpgsql
security invoker
set search_path = ''
as $$
declare card public.funnel_cards;
declare previous_stage text;
begin
  select * into card from public.funnel_cards where id = target_id for update;
  if card.id is null then raise exception 'Lead não encontrado'; end if;
  if not private.is_company_member(card.company_id) then raise exception 'Acesso negado'; end if;
  if target_stage not in ('lead','visit','proposal','contract','registry','deed') then
    raise exception 'Estágio inválido';
  end if;
  if private.has_company_role(card.company_id, array['broker'])
     and not exists (
       select 1 from public.employees e
        where e.id = card.broker_id and e.user_id = (select auth.uid())
     ) then
    raise exception 'Corretor não pode alterar lead de outro corretor';
  end if;
  previous_stage := card.current_stage;
  if previous_stage = target_stage then return card; end if;

  update public.funnel_cards
     set current_stage = target_stage,
         stage_entered_at = now(),
         updated_at = now()
   where id = card.id
   returning * into card;
  insert into public.funnel_history(company_id, card_id, from_stage, to_stage, changed_by)
  values (card.company_id, card.id, previous_stage, target_stage, (select auth.uid()));
  return card;
end;
$$;

create or replace function public.next_rps_number(target_company uuid, target_environment text, target_series text default '1')
returns bigint
language plpgsql
security invoker
set search_path = ''
as $$
declare next_number bigint;
begin
  if not private.can_manage_finance(target_company) then raise exception 'Acesso negado'; end if;
  insert into public.fiscal_sequences(company_id, environment, series, last_number)
  values (target_company, target_environment, target_series, 1)
  on conflict (company_id, environment, series)
  do update set last_number = public.fiscal_sequences.last_number + 1, updated_at = now()
  returning last_number into next_number;
  return next_number;
end;
$$;

-- Motor de comissão atômico: todo o grafo é confirmado ou revertido junto.
create or replace function public.generate_commission_for_sale(
  target_sale uuid,
  installment_count integer default 1,
  manager_percentage numeric default 0,
  captador_percentage numeric default 0
) returns uuid
language plpgsql
security invoker
set search_path = ''
as $$
declare s public.sales;
declare d public.developments;
declare commission_id uuid;
declare receivable_id uuid;
declare installment_id uuid;
declare payable_id uuid;
declare total numeric(18,2);
declare broker_pct numeric := 0;
declare brokerage_pct numeric;
declare receipt text;
declare receivable_total numeric(18,2);
declare installment_amount numeric(18,2);
declare n integer;
declare due_date date;
begin
  select * into s from public.sales where id = target_sale for update;
  if s.id is null then raise exception 'Venda não encontrada'; end if;
  if not private.can_manage_finance(s.company_id) then raise exception 'Acesso negado'; end if;
  if exists (select 1 from public.commissions where sale_id = s.id) then
    raise exception 'A venda já possui comissão';
  end if;
  select * into d from public.developments where id = s.development_id;
  if d.id is null or d.company_id <> s.company_id then raise exception 'Empreendimento inválido'; end if;

  installment_count := greatest(1, least(12, installment_count));
  manager_percentage := greatest(0, manager_percentage);
  captador_percentage := greatest(0, captador_percentage);
  broker_pct := coalesce(d.broker_split_percentage, 0);
  if broker_pct + manager_percentage + captador_percentage > 100 then
    raise exception 'A soma dos percentuais de comissão excede 100%%';
  end if;
  brokerage_pct := 100 - broker_pct - manager_percentage - captador_percentage;
  total := round(s.sale_value * coalesce(d.commission_percentage, 0) / 100, 2);
  if total <= 0 then raise exception 'Comissão calculada deve ser positiva'; end if;
  receipt := case when d.type = 'launch' then 'launch_passthrough' else 'resale_consolidated' end;

  insert into public.commissions(company_id, sale_id, total_amount, receipt_type, status)
  values (s.company_id, s.id, total, receipt, 'pending')
  returning id into commission_id;

  receivable_total := total;
  for n in 1..installment_count loop
    due_date := (coalesce(s.sale_date, current_date) + make_interval(months => n))::date;
    installment_amount := case
      when n = installment_count
        then receivable_total - round(receivable_total / installment_count, 2) * (installment_count - 1)
      else round(receivable_total / installment_count, 2)
    end;
    insert into public.receivables(
      company_id, client_name, client_document, sale_id, description, amount,
      due_date, competence_date, category_id, cost_center_id, invoice_rule,
      recurrence, status
    ) values (
      s.company_id,
      case when receipt = 'launch_passthrough' then d.developer else s.buyer_name end,
      s.buyer_document, s.id,
      'Comissão ' || d.name || ' — ' || coalesce(s.buyer_name, '') ||
        case when installment_count > 1 then format(' (%s/%s)', n, installment_count) else '' end,
      installment_amount, due_date, s.sale_date,
      (select id from public.chart_accounts where company_id = s.company_id and type = 'revenue' order by code nulls last limit 1),
      (select id from public.cost_centers where company_id = s.company_id order by created_at limit 1),
      'on_receive', 'once', 'open'
    ) returning id into receivable_id;

    insert into public.commission_installments(
      commission_id, installment_number, amount, expected_date, status, receivable_id
    ) values (commission_id, n, installment_amount, due_date, 'pending', receivable_id)
    returning id into installment_id;
    update public.receivables set commission_installment_id = installment_id where id = receivable_id;
  end loop;

  insert into public.commission_splits(commission_id, beneficiary_type, percentage, amount, status)
  values (commission_id, 'brokerage', brokerage_pct, round(total * brokerage_pct / 100, 2), 'not_applicable');

  if broker_pct > 0 then
    insert into public.payables(
      company_id, employee_id, description, amount, due_date, category_id,
      cost_center_id, recurrence, status, notes
    ) values (
      s.company_id, s.broker_id, 'Repasse comissão — ' || coalesce(s.buyer_name, ''),
      round(total * broker_pct / 100, 2),
      coalesce(s.sale_date, current_date) + interval '1 month',
      (select id from public.chart_accounts where company_id = s.company_id and type = 'expense' and name ilike '%repasse%' limit 1),
      (select id from public.cost_centers where company_id = s.company_id order by created_at limit 1),
      'once', 'open', 'Executar após recebimento da comissão.'
    ) returning id into payable_id;
  end if;
  insert into public.commission_splits(
    commission_id, beneficiary_type, beneficiary_id, percentage, amount, payable_id, status
  ) values (
    commission_id, 'broker', s.broker_id, broker_pct, round(total * broker_pct / 100, 2),
    payable_id, case when payable_id is null then 'not_applicable' else 'pending' end
  );
  if manager_percentage > 0 then
    insert into public.commission_splits(commission_id, beneficiary_type, percentage, amount, status)
    values (commission_id, 'manager', manager_percentage, round(total * manager_percentage / 100, 2), 'pending');
  end if;
  if captador_percentage > 0 then
    insert into public.commission_splits(commission_id, beneficiary_type, percentage, amount, status)
    values (commission_id, 'captador', captador_percentage, round(total * captador_percentage / 100, 2), 'pending');
  end if;
  return commission_id;
end;
$$;

revoke all on function public.settle_payable(uuid,numeric,timestamptz,text,text,text) from public, anon;
revoke all on function public.settle_receivable(uuid,numeric,timestamptz,text,text,text) from public, anon;
revoke all on function public.move_funnel_card(uuid,text) from public, anon;
revoke all on function public.next_rps_number(uuid,text,text) from public, anon;
revoke all on function public.generate_commission_for_sale(uuid,integer,numeric,numeric) from public, anon;
grant execute on function public.settle_payable(uuid,numeric,timestamptz,text,text,text) to authenticated;
grant execute on function public.settle_receivable(uuid,numeric,timestamptz,text,text,text) to authenticated;
grant execute on function public.move_funnel_card(uuid,text) to authenticated;
grant execute on function public.next_rps_number(uuid,text,text) to authenticated;
grant execute on function public.generate_commission_for_sale(uuid,integer,numeric,numeric) to authenticated;

-- Auditoria automática de alterações relevantes.
create or replace function private.audit_row_change()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare old_row jsonb;
declare new_row jsonb;
declare cid uuid;
declare eid text;
begin
  old_row := case when tg_op in ('UPDATE','DELETE') then to_jsonb(old) else null end;
  new_row := case when tg_op in ('INSERT','UPDATE') then to_jsonb(new) else null end;
  cid := coalesce(
    (new_row->>'company_id')::uuid,
    (old_row->>'company_id')::uuid,
    case when tg_table_name = 'companies' then coalesce((new_row->>'id')::uuid, (old_row->>'id')::uuid) end
  );
  eid := coalesce(new_row->>'id', old_row->>'id');
  insert into public.audit_log(company_id, actor_id, action, entity_type, entity_id, old_data, new_data, request_id)
  values (
    cid, (select auth.uid()), lower(tg_op), tg_table_name, eid, old_row, new_row,
    nullif(current_setting('request.headers', true)::jsonb->>'x-request-id', '')
  );
  if tg_op = 'DELETE' then
    return old;
  end if;
  return new;
end;
$$;
revoke all on function private.audit_row_change() from public, anon, authenticated;

do $$
declare t text;
begin
  foreach t in array array[
    'companies','company_members','chart_accounts','cost_centers','suppliers','clients',
    'employees','payables','receivables','transactions','developments','sales',
    'commissions','commission_installments','commission_splits','funnel_cards',
    'invoices','notification_rules','settlements','attachments'
  ]
  loop
    execute format('drop trigger if exists audit_%I on public.%I', t, t);
    execute format(
      'create trigger audit_%I after insert or update or delete on public.%I for each row execute function private.audit_row_change()',
      t, t
    );
  end loop;
end $$;

-- Bucket privado; caminho obrigatório: <company_uuid>/<entity>/<arquivo>.
insert into storage.buckets(id, name, public, file_size_limit, allowed_mime_types)
values (
  'financial-attachments', 'financial-attachments', false, 10485760,
  array['application/pdf','image/png','image/jpeg','text/csv',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet']
)
on conflict (id) do update
set public = false,
    file_size_limit = excluded.file_size_limit,
    allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists financial_attachments_select on storage.objects;
drop policy if exists financial_attachments_insert on storage.objects;
drop policy if exists financial_attachments_update on storage.objects;
drop policy if exists financial_attachments_delete on storage.objects;
create policy financial_attachments_select on storage.objects for select to authenticated
  using (
    bucket_id = 'financial-attachments'
    and private.is_company_member((storage.foldername(name))[1]::uuid)
  );
create policy financial_attachments_insert on storage.objects for insert to authenticated
  with check (
    bucket_id = 'financial-attachments'
    and private.can_manage_finance((storage.foldername(name))[1]::uuid)
  );
create policy financial_attachments_update on storage.objects for update to authenticated
  using (
    bucket_id = 'financial-attachments'
    and private.can_manage_finance((storage.foldername(name))[1]::uuid)
  )
  with check (
    bucket_id = 'financial-attachments'
    and private.can_manage_finance((storage.foldername(name))[1]::uuid)
  );
create policy financial_attachments_delete on storage.objects for delete to authenticated
  using (
    bucket_id = 'financial-attachments'
    and private.can_admin_company((storage.foldername(name))[1]::uuid)
  );

-- Grants explícitos: Data API acessível somente para usuários autenticados.
revoke all on all tables in schema public from anon;
revoke all on all sequences in schema public from anon;
revoke all on all functions in schema public from anon;
grant select, insert, update, delete on all tables in schema public to authenticated;
grant usage, select on all sequences in schema public to authenticated;
revoke truncate, references, trigger on all tables in schema public from authenticated;
revoke insert, update, delete on public.audit_log from authenticated;
revoke insert, update, delete on public.notifications from authenticated;

alter default privileges for role postgres in schema public
  revoke select, insert, update, delete on tables from anon, authenticated, service_role;
alter default privileges for role postgres in schema public
  revoke execute on functions from public, anon, authenticated, service_role;
alter default privileges for role postgres in schema public
  revoke usage, select on sequences from anon, authenticated, service_role;
