-- Defesa em profundidade: impede criação direta pela API pública de Auth.
-- Convites administrativos chegam com auth.users.invited_at preenchido.
create or replace function private.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if tg_op = 'INSERT' and new.invited_at is null then
    raise exception using
      errcode = '42501',
      message = 'Cadastro público desabilitado. Solicite um convite ao administrador.';
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
