-- Completa a trilha de auditoria das contas recebidas antes da introducao das
-- baixas explicitas. Os movimentos de caixa ja existem e nao sao recriados:
-- esta migracao apenas cria o settlement correspondente e faz a associacao.
--
-- Criterios conservadores:
--   * a conta possui saldo recebido;
--   * ainda nao possui nenhuma baixa;
--   * existe exatamente uma transacao de entrada ainda sem baixa;
--   * o valor da transacao coincide com o saldo recebido.
with legacy_receipts as (
  select
    r.id as receivable_id,
    r.company_id,
    r.received_amount,
    coalesce(r.received_at, t.date::timestamptz, r.updated_at, r.created_at, now()) as settled_at,
    coalesce(t.account, r.account) as account,
    t.id as transaction_id,
    t.created_at,
    (
      select member.user_id
      from public.company_members member
      where member.company_id = r.company_id
      order by
        case member.role
          when 'owner' then 0
          when 'admin' then 1
          else 2
        end,
        member.created_at
      limit 1
    ) as created_by
  from public.receivables r
  join public.transactions t
    on t.receivable_id = r.id
   and t.type = 'income'
   and not t.is_reversal
   and t.settlement_id is null
   and t.amount = r.received_amount
  where r.received_amount > 0
    and not exists (
      select 1
      from public.settlements s
      where s.receivable_id = r.id
    )
    and 1 = (
      select count(*)
      from public.transactions candidate
      where candidate.receivable_id = r.id
        and candidate.type = 'income'
        and not candidate.is_reversal
        and candidate.settlement_id is null
    )
),
inserted_receipts as (
  insert into public.settlements(
    company_id,
    receivable_id,
    type,
    amount,
    settled_at,
    account,
    notes,
    created_by,
    created_at
  )
  select
    company_id,
    receivable_id,
    'receipt',
    received_amount,
    settled_at,
    account,
    'Backfill automatico de recebimento legado',
    created_by,
    created_at
  from legacy_receipts
  returning id, receivable_id
)
update public.transactions t
   set settlement_id = inserted.id
  from inserted_receipts inserted
  join legacy_receipts legacy
    on legacy.receivable_id = inserted.receivable_id
 where t.id = legacy.transaction_id;
