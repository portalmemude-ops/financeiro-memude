-- ===========================================================================
-- A empresa passa a tratar o caixa como conta única. Os nomes de banco
-- (C6 OFICIAL, NUBANK, RENO, SÉRGIO) deixam de separar os saldos.
--
-- O banco de origem de cada lançamento continua registrado: nas observações
-- das contas e, na íntegra, na tabela de carga public.import_planilha_caixa.
-- ===========================================================================
do $$
declare v_conta text := 'Conta MeMude';
begin

-- guarda o banco original nas observações, uma única vez
update public.receivables r
   set notes = r.notes || format(' Banco original: %s.', s.conta)
  from public.import_planilha_caixa s
 where r.notes like '%[PLANILHA#' || s.idx || ']%'
   and r.notes not like '%Banco original:%'
   and s.conta is not null;

update public.payables p
   set notes = p.notes || format(' Banco original: %s.', s.conta)
  from public.import_planilha_caixa s
 where p.notes like '%[PLANILHA#' || s.idx || ']%'
   and p.notes not like '%Banco original:%'
   and s.conta is not null;

-- unifica a conta em todo o razão
update public.transactions set account = v_conta where account is distinct from v_conta;
update public.settlements  set account = v_conta where account is distinct from v_conta;
update public.receivables  set account = v_conta where account is distinct from v_conta;
update public.payables     set account = v_conta where account is distinct from v_conta;

end $$;
