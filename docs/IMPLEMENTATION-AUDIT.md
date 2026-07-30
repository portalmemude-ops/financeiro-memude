# Auditoria de implementação — Portal MeMude

## Escopo entregue

- Projeto independente, sem histórico ou dados da empresa de origem.
- Identidade Portal MeMude, cores, logo, favicon, títulos e textos.
- Cadastro fiscal e institucional do único CNPJ.
- Banco Supabase novo com RLS, auditoria, índices e migrações versionadas.
- Administrador inicial confirmado e vinculado como `super_admin`.
- Integração inicial e contínua com o MeMude Core.
- Imagem Docker e pipeline GHCR para Dokploy.

## Estado dos dados

Dados operacionais importados do Core:

- 1 corretor
- 488 empreendimentos
- 6 leads/clientes
- 2 vendas
- 2 comissões

Dados financeiros iniciados em zero:

- contas a pagar: 0
- contas a receber: 0
- transações: 0
- notas fiscais: 0

Foram criados apenas os cadastros estruturais necessários: empresa, plano de
contas, centros de custo e estados de sincronização.

## Controles de segurança

- Cadastro público bloqueado por autorização de convite de uso único.
- Bootstrap inicial removido após a criação do administrador.
- Segredos da integração do Core mantidos no Vault ou no runtime das funções.
- Webhook com segredo de alta entropia e execução assíncrona.
- RLS ativa em todas as tabelas públicas.
- Tabelas server-only possuem políticas explícitas de negação.
- Chaves estrangeiras possuem índices de cobertura.
- NFS-e permanece desabilitada até configuração fiscal e certificado A1.

## Validações executadas

- ESLint: aprovado.
- TypeScript/Nuxt typecheck: aprovado.
- 66 testes automatizados: aprovados.
- Build SSR de produção: aprovado.
- Login real: aprovado.
- Renderização visual: logo, navegação, painel e ausência de overlay/erros.
- Importação repetida: sem duplicações.
- Webhook Core → Financeiro: HTTP 200 e reconciliação sem erro.
- Supabase Advisors: sem alertas de RLS ou chaves estrangeiras sem índice.

## Observação de plataforma

O Supabase Advisor recomenda ativar **Leaked Password Protection** em
Authentication → Attack Protection. Essa opção é de painel/planos do Supabase e
não é alterada por migração SQL. Referência:
https://supabase.com/docs/guides/auth/password-security#password-strength-and-leaked-password-protection

