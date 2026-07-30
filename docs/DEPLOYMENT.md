# Deploy do MeMude Financeiro

## Arquitetura

- Aplicação: Nuxt 3 SSR em container Node 22.
- Imagem: `ghcr.io/portalmemude-ops/financeiro-memude:latest`.
- Produção: `https://financas.memudecore.com.br`.
- Supabase Financeiro: `syeidxevgupqziwirwdz` (`sa-east-1`).
- Supabase Core: `oxybasvtphosdmlmrfnb`.
- Integração: Edge Functions privadas e webhooks assíncronos com segredos no Vault.

## Variáveis obrigatórias no GitHub

Em **Settings → Secrets and variables → Actions → Variables**:

- `SUPABASE_URL`: `https://syeidxevgupqziwirwdz.supabase.co`
- `SUPABASE_KEY`: chave pública `sb_publishable_...` do projeto.

O workflow valida lint, tipos, testes e build antes de publicar a imagem.

## Configuração no Dokploy

Crie uma aplicação por Docker Compose usando `docker-compose.yml` e configure:

- `NUXT_PUBLIC_SUPABASE_URL`
- `NUXT_PUBLIC_SUPABASE_KEY`
- `NUXT_SUPABASE_SECRET_KEY` (chave server-side do projeto; necessária para convites e operações administrativas)

Variáveis opcionais estão documentadas em `.env.example`. Nunca envie `.env`,
certificados ou segredos para o Git.

O domínio deve apontar para a VPS e o roteador Traefik provisionará TLS:

`financas.memudecore.com.br`

## Verificação após deploy

1. Confirmar `GET /api/health` com HTTP 200.
2. Entrar com o administrador inicial.
3. Abrir **Integração Core** e confirmar os quatro recursos sem erro.
4. Criar um registro de teste e confirmar persistência após recarregar a página.
5. Conferir logs do container e o estado de saúde no Dokploy.

## Operação da integração

Alterações em `corretores`, `empreendimentos`, `leads` e `vendas` no Core
disparam `pg_net` de forma assíncrona. A função `core-sync` reconcilia os dados
pela chave externa, portanto pode ser repetida sem duplicação. Cadastros de
origem `manual` não são sobrescritos.
