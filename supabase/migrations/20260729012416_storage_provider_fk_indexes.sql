create index if not exists company_storage_settings_connected_by_idx
  on public.company_storage_settings(connected_by)
  where connected_by is not null;

create index if not exists storage_oauth_states_company_id_idx
  on public.storage_oauth_states(company_id);

create index if not exists storage_oauth_states_user_id_idx
  on public.storage_oauth_states(user_id);
