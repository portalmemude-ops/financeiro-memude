-- The service role alone can read the credential used for signed Core exports.
create schema if not exists private;
revoke all on schema private from public, anon, authenticated;
alter table public.sales add column if not exists core_payload jsonb;
create or replace function public.get_core_sync_config() returns jsonb
language sql security definer set search_path='' as $$
  select jsonb_build_object('url','https://oxybasvtphosdmlmrfnb.supabase.co/functions/v1/finance-export',
    'secret',(select decrypted_secret from vault.decrypted_secrets where name='core_signed_export_secret' limit 1))
$$;
revoke all on function public.get_core_sync_config() from public,anon,authenticated;
grant execute on function public.get_core_sync_config() to service_role;
