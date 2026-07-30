# MeMude Financeiro

Sistema financeiro do Portal MeMude, construído com Nuxt 3, Vue 3, Vuetify,
Pinia e Supabase.

## Escopo

- contas a pagar e receber, liquidações, estornos e fluxo de caixa;
- plano de contas, centros de custo e fornecedores;
- vendas, empreendimentos, clientes, corretores e comissões;
- sincronização idempotente com o MeMude Core;
- relatórios, auditoria, notificações e importação manual;
- anexos privados no Supabase Storage e Google Drive opcional;
- NFS-e Fortaleza disponível apenas após configuração fiscal explícita.

O MeMude Core é a fonte oficial para corretores, empreendimentos, leads e
vendas. Cadastros financeiros manuais continuam independentes.

## Desenvolvimento

```bash
pnpm install
pnpm dev
pnpm verify
```

Copie `.env.example` para `.env` e informe as credenciais do projeto Supabase.
Nunca versione chaves secretas ou certificados.

## Produção

- domínio: `https://financas.memudecore.com.br`;
- imagem: `ghcr.io/portalmemude-ops/memude-financeiro`;
- runtime: Node.js 22 / Nitro;
- orquestração: Dokploy com Traefik;
- health check: `GET /api/health`.

Consulte `docs/DEPLOY-MEMUDE.md` para o runbook de implantação.
