-- Corrige a atribuicao do retorno composto de settle_receivable no fluxo em
-- que uma conta e cadastrada ja como recebida. Sem o FROM, o PostgreSQL tenta
-- converter o registro inteiro para a primeira coluna UUID e reverte a operacao.
--
-- A migracao e compativel tanto com bancos que receberam a versao anterior
-- quanto com instalacoes novas, nas quais a migracao base ja contem a correcao.
do $migration$
declare
  function_definition text;
  buggy_call constant text := 'select public.settle_receivable(';
  fixed_call constant text := 'select * from public.settle_receivable(';
begin
  select pg_get_functiondef(
    'public.save_receivable_entry(uuid,jsonb,jsonb,jsonb)'::regprocedure
  )
    into function_definition;

  if position(buggy_call in lower(function_definition)) > 0 then
    function_definition := replace(function_definition, buggy_call, fixed_call);
    execute function_definition;
  end if;

  if position(fixed_call in lower(function_definition)) = 0
     and position(buggy_call in lower(function_definition)) = 0 then
    raise exception 'Formato inesperado de save_receivable_entry';
  end if;
end
$migration$;
