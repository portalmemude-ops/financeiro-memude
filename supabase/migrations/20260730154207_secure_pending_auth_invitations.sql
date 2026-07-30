-- Lista de uso único para autorizar criações administrativas no Supabase Auth.
-- A versão atual do GoTrue pode persistir invited_at após o INSERT; por isso a
-- autorização é comprovada antes pelo servidor e consumida atomicamente.
create table if not exists public.auth_invitations (
  email text primary key check (email = lower(trim(email))),
  requested_by uuid references auth.users(id) on delete set null,
  expires_at timestamptz not null default (now() + interval '15 minutes'),
  created_at timestamptz not null default now()
);

alter table public.auth_invitations enable row level security;
revoke all on table public.auth_invitations from public, anon, authenticated;
grant all on table public.auth_invitations to service_role;

create index if not exists auth_invitations_expires_idx
  on public.auth_invitations(expires_at);

create or replace function private.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  approved_email text;
begin
  if tg_op = 'INSERT' and new.invited_at is null then
    delete from public.auth_invitations
    where email = lower(trim(new.email))
      and expires_at > now()
    returning email into approved_email;

    if approved_email is null then
      raise exception using
        errcode = '42501',
        message = 'Cadastro público desabilitado. Solicite um convite ao administrador.';
    end if;
  else
    delete from public.auth_invitations
    where email = lower(trim(new.email));
  end if;

  insert into public.user_profiles(id, full_name, email)
  values (new.id, nullif(new.raw_user_meta_data->>'full_name', ''), new.email)
  on conflict (id) do update
    set full_name = coalesce(excluded.full_name, public.user_profiles.full_name),
        email = excluded.email;

  return new;
end;
$$;

revoke all on function private.handle_new_user() from public, anon, authenticated;
