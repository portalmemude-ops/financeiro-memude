# Implementação das Fases 0 e 1

Data: 28/07/2026
Branch: `codex/fases-0-1-seguranca-persistencia`

## Escopo concluído

- Autorização multiempresa por vínculo e papel, aplicada no Postgres com RLS.
- Funções privilegiadas isoladas no schema `private`, com `search_path` seguro.
- Cadastro público removido; onboarding realizado por convite administrativo.
- Endpoints fiscais autenticados, autorizados, limitados e desabilitados por padrão.
- NFS-e sem simulação de sucesso e com sequência de RPS reservada no banco.
- Contas a pagar/receber, baixas parciais, transações, recorrências, comissões,
  funil, notas, notificações e anexos persistidos.
- Baixas, comissão e movimento de funil executados por operações atômicas.
- Anexos em bucket privado, com escopo por empresa, validação e URL assinada.
- Auditoria automática das alterações financeiras e administrativas relevantes.
- Hidratação global com estado de carregamento, falha recuperável e página sem acesso.
- Cabeçalhos de segurança, Docker sem credenciais fixas e CI com quality gate.

## Migrações aplicadas em produção

Histórico confirmado no projeto `nzrwlmjhbbmqlwfxqgsd`:

1. `20260728104709` — `remote_schema_baseline`
2. `20260728104848` — `phases_0_1_security_persistence`
3. `20260728105036` — `production_readiness_indexes`
4. `20260728105250` — `enforce_invitation_only_auth`

O arquivo legado `0001_init.sql` foi removido porque não representava o schema
real do projeto remoto. O baseline novo é idempotente e foi derivado do banco
existente.

Antes do rollout foi criado o schema isolado `backup_phase01_20260728`. As 16
tabelas originais e 330 linhas foram comparadas com a origem, sem divergências.
O schema não possui acesso para `public`, `anon` ou `authenticated`.

## Configurações operacionais pendentes

1. Configurar `SUPABASE_SERVICE_ROLE_KEY` somente no runtime do servidor.
2. Habilitar proteção contra senhas vazadas no Supabase Auth.
3. Manter `NFSE_ENABLED=0` até homologar certificado, XML e provedor.
4. Obter acesso aos backups gerenciados e fazer um ensaio de restauração.

## Pendências conhecidas

- Existem 12 vendas legadas com `sale_value = 0`. A migração impede novos casos,
  mas cria a constraint como `NOT VALID` até o saneamento desses registros.
- O audit de dependências mantém dois alertas altos transitivos em
  `brace-expansion`. Não há vulnerabilidade crítica; o CI exibe os alertas e
  bloqueia qualquer vulnerabilidade crítica.
- O acesso aos backups gerenciados continua retornando `403`. O snapshot lógico
  interno deve ser mantido até existir um backup gerenciado e restaurável.

## Evidências de validação

- ESLint: aprovado.
- TypeScript (`nuxi typecheck`): aprovado.
- Testes automatizados: 36 aprovados, 0 falhas.
- Build de produção: aprovado.
- Health check: HTTP 200.
- APIs fiscais e convite sem sessão: HTTP 401.
- Rotas privadas sem sessão: redirecionamento para `/login`.
- Cadastro público: substituído por orientação de convite.
- Página de convite: senha mínima de 12 caracteres.
- Console do navegador no login: sem erros.
- 25 de 25 tabelas públicas com RLS e 90 políticas.
- `anon` sem leitura nas tabelas públicas e sem execução das RPCs financeiras.
- Teste RLS autenticado sem linhas de outra empresa.
- Baixa transacional comprovou settlement, transaction e auditoria; rollback
  confirmou que o smoke test não alterou dados reais.
- Cadastro direto via Supabase Auth rejeitado, sem usuário residual.
- Advisor de segurança sem alertas de funções/RLS; resta apenas a configuração
  de proteção contra senhas vazadas.
- Advisor de performance sem FKs sem índice e sem índices duplicados.

## Rollout recomendado

1. Configurar a service role e enviar um convite de homologação.
2. Habilitar proteção contra senhas vazadas no painel do Supabase Auth.
3. Publicar a imagem somente após o quality gate.
4. Testar os demais papéis quando houver usuários `admin`, `financial`,
   `broker`, `accountant` e `viewer`; atualmente os seis vínculos são
   `super_admin`.
5. Observar logs, erros 4xx/5xx e trilha de auditoria por pelo menos 24 horas.
6. Remover `backup_phase01_20260728` somente após confirmar um backup gerenciado.
