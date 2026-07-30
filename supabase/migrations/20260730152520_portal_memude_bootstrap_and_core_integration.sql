-- Portal MeMude: configuração legal, dados iniciais não transacionais e
-- infraestrutura idempotente de integração com o MeMude Core.

alter table public.companies add column if not exists address_line text;
alter table public.companies add column if not exists neighborhood text;
alter table public.companies add column if not exists postal_code text;
alter table public.companies add column if not exists phone text;
alter table public.companies add column if not exists mobile_phone text;
alter table public.companies add column if not exists updated_at timestamptz not null default now();

create unique index if not exists companies_cnpj_uidx
  on public.companies(cnpj)
  where cnpj is not null and cnpj <> '';

alter table public.employees add column if not exists core_corretor_id uuid;
alter table public.employees add column if not exists source text not null default 'manual'
  check (source in ('manual', 'memude_core'));
alter table public.employees add column if not exists source_updated_at timestamptz;

alter table public.developments add column if not exists core_empreendimento_id uuid;
alter table public.developments add column if not exists source text not null default 'manual'
  check (source in ('manual', 'memude_core'));
alter table public.developments add column if not exists source_updated_at timestamptz;

alter table public.clients add column if not exists core_lead_id uuid;
alter table public.clients add column if not exists source text not null default 'manual'
  check (source in ('manual', 'memude_core'));
alter table public.clients add column if not exists source_updated_at timestamptz;

alter table public.sales add column if not exists core_venda_id uuid;
alter table public.sales add column if not exists core_lead_id uuid;
alter table public.sales add column if not exists source text not null default 'manual'
  check (source in ('manual', 'memude_core'));
alter table public.sales add column if not exists source_updated_at timestamptz;
alter table public.sales add column if not exists sync_hash text;

alter table public.commissions add column if not exists core_venda_id uuid;
alter table public.commissions add column if not exists source text not null default 'manual'
  check (source in ('manual', 'memude_core'));
alter table public.commissions add column if not exists source_updated_at timestamptz;

create unique index if not exists employees_company_core_corretor_uidx
  on public.employees(company_id, core_corretor_id);
create unique index if not exists developments_company_core_empreendimento_uidx
  on public.developments(company_id, core_empreendimento_id);
create unique index if not exists clients_company_core_lead_uidx
  on public.clients(company_id, core_lead_id);
create unique index if not exists sales_company_core_venda_uidx
  on public.sales(company_id, core_venda_id);
create unique index if not exists commissions_company_core_venda_uidx
  on public.commissions(company_id, core_venda_id);
create unique index if not exists commission_splits_commission_beneficiary_uidx
  on public.commission_splits(commission_id, beneficiary_type);

create table public.integration_events (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  event_id uuid not null,
  source text not null check (source in ('memude_core', 'memude_financeiro')),
  event_type text not null,
  schema_version integer not null default 1 check (schema_version > 0),
  correlation_id text,
  entity_type text not null,
  entity_id uuid,
  payload jsonb not null default '{}'::jsonb,
  payload_hash text not null,
  status text not null default 'pending'
    check (status in ('pending', 'processing', 'processed', 'ignored', 'failed')),
  attempts integer not null default 0 check (attempts >= 0),
  last_error text,
  occurred_at timestamptz not null,
  processed_at timestamptz,
  next_retry_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(source, event_id)
);

create table public.integration_sync_state (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  source text not null check (source in ('memude_core', 'memude_financeiro')),
  resource text not null check (resource in ('corretores', 'empreendimentos', 'leads', 'vendas')),
  cursor jsonb not null default '{}'::jsonb,
  last_started_at timestamptz,
  last_completed_at timestamptz,
  last_success_at timestamptz,
  last_error text,
  records_processed integer not null default 0 check (records_processed >= 0),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(company_id, source, resource)
);

create table public.integration_conflicts (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  source text not null,
  entity_type text not null,
  external_id uuid not null,
  local_id uuid,
  reason text not null,
  source_data jsonb not null default '{}'::jsonb,
  local_data jsonb,
  status text not null default 'open'
    check (status in ('open', 'resolved', 'ignored')),
  resolved_by uuid references auth.users(id),
  resolved_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index integration_events_status_retry_idx
  on public.integration_events(status, next_retry_at, created_at)
  where status in ('pending', 'failed');
create index integration_events_company_created_idx
  on public.integration_events(company_id, created_at desc);
create index integration_events_entity_idx
  on public.integration_events(entity_type, entity_id);
create index integration_conflicts_company_status_idx
  on public.integration_conflicts(company_id, status, created_at desc);

alter table public.integration_events enable row level security;
alter table public.integration_sync_state enable row level security;
alter table public.integration_conflicts enable row level security;

create policy integration_events_admin_select
  on public.integration_events for select to authenticated
  using (private.can_admin_company(company_id));
create policy integration_sync_state_admin_select
  on public.integration_sync_state for select to authenticated
  using (private.can_admin_company(company_id));
create policy integration_conflicts_admin_select
  on public.integration_conflicts for select to authenticated
  using (private.can_admin_company(company_id));
create policy integration_conflicts_admin_update
  on public.integration_conflicts for update to authenticated
  using (private.can_admin_company(company_id))
  with check (private.can_admin_company(company_id));

revoke all on public.integration_events from anon;
revoke all on public.integration_sync_state from anon;
revoke all on public.integration_conflicts from anon;
grant select on public.integration_events to authenticated;
grant select on public.integration_sync_state to authenticated;
grant select, update on public.integration_conflicts to authenticated;

insert into public.companies (
  id, name, trade_name, type, cnpj, municipal_registration, creci,
  address_line, neighborhood, postal_code, mobile_phone, city, state,
  city_ibge, logo_color, invoice_config, tax_config
)
values (
  '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6',
  'Delta Assessoria Imobiliária',
  'Portal MeMude',
  'real_estate',
  '26439023000190',
  '0653942-4',
  '20882J',
  'Av. Desembargador Moreira, 1300 (BS Design) - Torre Norte - Sala 711',
  'Aldeota',
  '60170-002',
  '85991465236',
  'Fortaleza',
  'CE',
  '2304400',
  'primary',
  jsonb_build_object(
    'provider', 'ginfes',
    'environment', 'homologacao',
    'municipalityIbge', '2304400',
    'enabled', false,
    'defaultCnae', '',
    'defaultIssRate', 0,
    'defaultServiceDescription', '',
    'rpsSeries', '1'
  ),
  '{}'::jsonb
);

insert into public.chart_accounts (id, company_id, code, name, type, parent_id, is_active)
values
  ('c2d054cf-f191-4f8a-92c2-4c6522f65111', '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', '1', 'Receitas', 'revenue', null, true),
  ('29c891b9-229f-4ed3-86bd-440b6a03a8e7', '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', '1.1', 'Comissões de vendas', 'revenue', 'c2d054cf-f191-4f8a-92c2-4c6522f65111', true),
  ('340e81bb-405b-40d6-b1a2-55d12e642ea3', '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', '1.2', 'Outras receitas', 'revenue', 'c2d054cf-f191-4f8a-92c2-4c6522f65111', true),
  ('84dd4d31-02e2-4032-8816-fd574c04bf01', '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', '2', 'Despesas', 'expense', null, true),
  ('decc672c-f5ac-43a4-ac4f-26ff1f6744bc', '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', '2.1', 'Repasse de comissões', 'expense', '84dd4d31-02e2-4032-8816-fd574c04bf01', true),
  ('17fbc727-011a-4e68-a295-bc8674024c89', '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', '2.2', 'Despesas administrativas', 'expense', '84dd4d31-02e2-4032-8816-fd574c04bf01', true),
  ('8e01359e-424b-4582-831f-118120011c18', '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', '2.3', 'Marketing e tecnologia', 'expense', '84dd4d31-02e2-4032-8816-fd574c04bf01', true),
  ('b1995d45-f5ba-43ee-8bfc-a91e6f54639b', '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', '2.4', 'Impostos e taxas', 'expense', '84dd4d31-02e2-4032-8816-fd574c04bf01', true);

insert into public.cost_centers (id, company_id, name, description, is_active)
values
  ('ca58837b-858f-48af-8f3c-2cb001e9026c', '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', 'Administrativo', 'Custos administrativos e operacionais', true),
  ('dd6b78e1-1a17-4345-970d-d1111e22caf5', '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', 'Comercial', 'Operação comercial, vendas e corretores', true),
  ('6c25a0b1-078f-4807-9538-e8175344960a', '5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', 'Marketing e Tecnologia', 'Aquisição, comunicação e tecnologia', true);

insert into public.integration_sync_state (company_id, source, resource)
values
  ('5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', 'memude_core', 'corretores'),
  ('5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', 'memude_core', 'empreendimentos'),
  ('5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', 'memude_core', 'leads'),
  ('5f82f8ea-a7dd-4e8f-b3a4-6b418740d0c6', 'memude_core', 'vendas');
