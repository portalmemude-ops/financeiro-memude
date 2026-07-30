# =============================================================================
# MeMude Financeiro — imagem de produção (Nuxt 3 SSR / preset node-server do Nitro).
# Feita para deploy em container no Dokploy (VPS Hostinger). Multi-stage:
# build (com devDependencies) -> runtime enxuto só com o .output.
# =============================================================================

# ---- base (pnpm via corepack; versão vem do campo "packageManager") ----
FROM node:22-alpine AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
WORKDIR /app

# ---- build ----
FROM base AS build
# A URL e a publishable key são públicas, mas não ficam vinculadas ao repositório.
# O pipeline deve fornecê-las por build-arg e o deploy repeti-las em runtime.
ARG NUXT_PUBLIC_SUPABASE_URL
ARG NUXT_PUBLIC_SUPABASE_KEY
ENV NUXT_PUBLIC_SUPABASE_URL=$NUXT_PUBLIC_SUPABASE_URL
ENV NUXT_PUBLIC_SUPABASE_KEY=$NUXT_PUBLIC_SUPABASE_KEY

# Cache de dependências separado; postinstall roda depois que o código existe.
COPY package.json pnpm-lock.yaml .npmrc ./
RUN pnpm install --frozen-lockfile --ignore-scripts
COPY . .
RUN pnpm rebuild && pnpm postinstall
RUN pnpm build

# ---- runtime ----
FROM node:22-alpine AS runtime
WORKDIR /app
ENV NODE_ENV=production
# Nitro escuta nestas variáveis; 0.0.0.0 é obrigatório dentro do container.
ENV HOST=0.0.0.0
ENV PORT=3000
ENV NITRO_PORT=3000

# Apenas a saída do build é necessária em produção.
COPY --from=build --chown=node:node /app/.output ./.output

EXPOSE 3000
USER node

# Health check do container (usado pelo Docker/Dokploy). Node 22 tem fetch global.
HEALTHCHECK --interval=30s --timeout=5s --start-period=25s --retries=3 \
  CMD node -e "fetch('http://127.0.0.1:'+(process.env.PORT||3000)+'/api/health').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"

CMD ["node", ".output/server/index.mjs"]
