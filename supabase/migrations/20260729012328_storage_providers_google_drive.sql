-- Persistent, tenant-aware attachment providers.
alter table public.attachments
  add column if not exists provider text not null default 'internal',
  add column if not exists external_file_id text,
  add column if not exists external_parent_id text,
  add column if not exists updated_at timestamptz not null default now();

alter table public.attachments alter column bucket_id drop not null;
alter table public.attachments alter column object_path drop not null;

alter table public.attachments
  drop constraint if exists attachments_provider_check,
  add constraint attachments_provider_check check (provider in ('internal', 'google_drive')),
  drop constraint if exists attachments_provider_location_check,
  add constraint attachments_provider_location_check check (
    (provider = 'internal' and bucket_id is not null and object_path is not null)
    or (provider = 'google_drive' and external_file_id is not null)
  );

create unique index if not exists attachments_google_file_unique
  on public.attachments(company_id, external_file_id)
  where provider = 'google_drive' and external_file_id is not null;

create table if not exists public.company_storage_settings (
  company_id uuid primary key references public.companies(id) on delete cascade,
  active_provider text not null default 'internal'
    check (active_provider in ('internal', 'google_drive')),
  google_account_email text,
  google_root_folder_id text,
  google_refresh_token_ciphertext text,
  google_scopes text[] not null default '{}',
  connected_by uuid references auth.users(id) on delete set null,
  connected_at timestamptz,
  updated_at timestamptz not null default now(),
  constraint google_drive_activation_requires_connection check (
    active_provider <> 'google_drive'
    or (google_refresh_token_ciphertext is not null and google_root_folder_id is not null)
  )
);

create table if not exists public.storage_oauth_states (
  state_hash text primary key,
  company_id uuid not null references public.companies(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  expires_at timestamptz not null,
  created_at timestamptz not null default now()
);

create index if not exists storage_oauth_states_expires_idx
  on public.storage_oauth_states(expires_at);

alter table public.company_storage_settings enable row level security;
alter table public.storage_oauth_states enable row level security;

-- These tables contain OAuth secrets and are deliberately server-only.
revoke all on public.company_storage_settings from anon, authenticated;
revoke all on public.storage_oauth_states from anon, authenticated;
grant all on public.company_storage_settings to service_role;
grant all on public.storage_oauth_states to service_role;

comment on table public.company_storage_settings is
  'Server-only per-company storage provider settings; encrypted OAuth refresh tokens.';
comment on table public.storage_oauth_states is
  'Short-lived, single-use Google OAuth states stored as SHA-256 digests.';
