create policy auth_invitations_service_only
  on public.auth_invitations for all to anon, authenticated
  using (false) with check (false);

create policy company_storage_settings_service_only
  on public.company_storage_settings for all to anon, authenticated
  using (false) with check (false);

create policy storage_oauth_states_service_only
  on public.storage_oauth_states for all to anon, authenticated
  using (false) with check (false);
