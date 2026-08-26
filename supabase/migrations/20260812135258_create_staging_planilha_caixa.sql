-- Área de carga temporária da planilha "MeMude - Fluxo de Caixa".
-- Sem RLS pública: acessível apenas por service role / superusuário.
create table if not exists public.import_planilha_caixa (
  idx           integer primary key,
  data          date not null,
  vencimento    date,
  tipo          text not null,
  centro_custo  text,
  descricao     text not null,
  conta         text,
  valor         numeric(18,2) not null,
  responsavel   text,
  comprovante   text
);

alter table public.import_planilha_caixa enable row level security;

drop policy if exists import_planilha_caixa_service_only on public.import_planilha_caixa;
create policy import_planilha_caixa_service_only
  on public.import_planilha_caixa
  for all using (false) with check (false);
