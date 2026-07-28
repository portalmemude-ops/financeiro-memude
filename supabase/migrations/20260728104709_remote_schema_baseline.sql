-- Baseline idempotente do schema encontrado em produção em 2026-07-27.
-- Este arquivo substitui a antiga 0001_init.sql, que descrevia outro modelo.
-- Em produção, os objetos já existem; em ambientes novos, este baseline cria
-- a estrutura mínima sobre a qual as migrações seguintes operam.

create extension if not exists pgcrypto;

create table if not exists public.companies (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  trade_name text,
  type text not null check (type in ('real_estate', 'agency')),
  cnpj text,
  state_registration text,
  municipal_registration text,
  main_cnae text,
  tax_regime text check (tax_regime in ('simples_nacional', 'lucro_presumido', 'lucro_real')),
  creci text,
  city text,
  state text,
  city_ibge text,
  logo_color text,
  certificate_expiry date,
  invoice_config jsonb not null default '{}'::jsonb,
  tax_config jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create table if not exists public.user_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  email text,
  phone text,
  avatar_url text,
  created_at timestamptz not null default now()
);

create table if not exists public.company_members (
  user_id uuid not null references auth.users(id) on delete cascade,
  company_id uuid not null references public.companies(id) on delete cascade,
  role text not null default 'viewer'
    check (role in ('super_admin', 'admin', 'financial', 'broker', 'accountant', 'viewer')),
  created_at timestamptz not null default now(),
  primary key (user_id, company_id)
);

create table if not exists public.chart_accounts (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  code text,
  name text not null,
  type text not null check (type in ('revenue', 'expense')),
  parent_id uuid references public.chart_accounts(id),
  created_at timestamptz not null default now()
);

create table if not exists public.cost_centers (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  name text not null,
  description text,
  created_at timestamptz not null default now()
);

create table if not exists public.suppliers (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  legal_name text not null,
  trade_name text,
  document text,
  email text,
  phone text,
  is_active boolean not null default true,
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists public.clients (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  name text not null,
  document text,
  email text,
  phone text,
  address text,
  city text,
  state text,
  notes text,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.employees (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  user_id uuid references auth.users(id) on delete set null,
  full_name text not null,
  email text,
  phone text,
  document text,
  employment_type text check (employment_type in ('clt', 'pj', 'commission_only', 'intern')),
  status text not null default 'active' check (status in ('active', 'inactive')),
  salary numeric,
  role_title text,
  created_at timestamptz not null default now()
);

create table if not exists public.developments (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  name text not null,
  developer text,
  address text,
  type text check (type in ('launch', 'resale')),
  commission_percentage numeric,
  broker_split_percentage numeric,
  is_active boolean not null default true,
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists public.sales (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  development_id uuid references public.developments(id),
  unit text,
  sale_value numeric not null default 0,
  buyer_name text,
  buyer_document text,
  buyer_contact text,
  payment_method text,
  broker_id uuid references public.employees(id),
  sale_date date,
  status text not null default 'completed'
    check (status in ('in_progress', 'completed', 'cancelled')),
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists public.commissions (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  sale_id uuid references public.sales(id),
  total_amount numeric not null default 0,
  receipt_type text check (receipt_type in ('launch_passthrough', 'resale_consolidated', 'resale_split')),
  status text not null default 'received' check (status in ('pending', 'partial', 'received')),
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists public.payables (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  supplier_id uuid references public.suppliers(id),
  employee_id uuid references public.employees(id),
  description text not null,
  amount numeric not null,
  due_date date not null,
  competence_date date,
  category_id uuid references public.chart_accounts(id),
  cost_center_id uuid references public.cost_centers(id),
  recurrence text not null default 'once' check (recurrence in ('once', 'monthly', 'installment')),
  recurrence_day integer,
  installment_number integer,
  total_installments integer,
  parent_payable_id uuid references public.payables(id),
  status text not null default 'open' check (status in ('open', 'paid', 'overdue', 'cancelled')),
  payment_method text,
  account text,
  paid_at timestamptz,
  proof_url text,
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists public.receivables (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  client_name text,
  client_document text,
  sale_id uuid references public.sales(id),
  commission_installment_id uuid,
  description text not null,
  amount numeric not null,
  due_date date not null,
  competence_date date,
  category_id uuid references public.chart_accounts(id),
  cost_center_id uuid references public.cost_centers(id),
  invoice_rule text not null default 'on_receive'
    check (invoice_rule in ('on_receive', 'scheduled', 'recurring', 'manual', 'none')),
  recurrence text not null default 'once' check (recurrence in ('once', 'monthly')),
  status text not null default 'open' check (status in ('open', 'received', 'overdue', 'cancelled')),
  account text,
  received_at timestamptz,
  proof_url text,
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists public.transactions (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  type text not null check (type in ('income', 'expense')),
  amount numeric not null,
  date date not null,
  description text,
  account text,
  category_id uuid references public.chart_accounts(id),
  cost_center_id uuid references public.cost_centers(id),
  payable_id uuid references public.payables(id),
  receivable_id uuid references public.receivables(id),
  created_at timestamptz not null default now()
);

create table if not exists public.commission_installments (
  id uuid primary key default gen_random_uuid(),
  commission_id uuid not null references public.commissions(id) on delete cascade,
  installment_number integer not null default 1,
  amount numeric not null default 0,
  expected_date date,
  received_date date,
  status text not null default 'received'
    check (status in ('pending', 'received', 'overdue', 'cancelled')),
  receivable_id uuid references public.receivables(id)
);

create table if not exists public.commission_splits (
  id uuid primary key default gen_random_uuid(),
  commission_id uuid not null references public.commissions(id) on delete cascade,
  beneficiary_type text check (beneficiary_type in ('agency', 'broker', 'manager', 'captador')),
  beneficiary_id uuid references public.employees(id),
  percentage numeric,
  amount numeric not null default 0,
  payable_id uuid references public.payables(id),
  status text not null default 'pending' check (status in ('pending', 'paid'))
);

create index if not exists company_members_company_idx on public.company_members(company_id, user_id);
create index if not exists chart_accounts_company_idx on public.chart_accounts(company_id);
create index if not exists cost_centers_company_idx on public.cost_centers(company_id);
create index if not exists suppliers_company_idx on public.suppliers(company_id);
create index if not exists clients_company_idx on public.clients(company_id);
create index if not exists employees_company_idx on public.employees(company_id);
create index if not exists developments_company_idx on public.developments(company_id);
create index if not exists sales_company_idx on public.sales(company_id);
create index if not exists commissions_company_idx on public.commissions(company_id);
create index if not exists payables_company_idx on public.payables(company_id);
create index if not exists receivables_company_idx on public.receivables(company_id);
create index if not exists transactions_company_idx on public.transactions(company_id);
