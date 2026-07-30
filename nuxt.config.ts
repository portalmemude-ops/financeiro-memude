import { fileURLToPath } from 'node:url'
import svgLoader from 'vite-svg-loader'
import vuetify from 'vite-plugin-vuetify'

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  app: {
    head: {
      titleTemplate: '%s · MeMude Financeiro',
      title: 'MeMude Financeiro',

      meta: [
        { name: 'description', content: 'Gestão financeira do Portal MeMude.' },
        { name: 'theme-color', content: '#422f91' },
        { property: 'og:title', content: 'MeMude Financeiro' },
        { property: 'og:description', content: 'Gestão financeira do Portal MeMude.' },
        { property: 'og:image', content: '/portal-memude-social.png' },
      ],

      link: [{ rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' }],
    },
  },

  routeRules: {
    '/': { redirect: '/dashboard' },
  },

  runtimeConfig: {
    coreSupabaseUrl: process.env.CORE_SUPABASE_URL,
    coreSupabaseServiceRoleKey: process.env.CORE_SUPABASE_SERVICE_ROLE_KEY,
    coreApiUrl: process.env.CORE_API_URL,
    coreApiSecret: process.env.CORE_API_SECRET,
    coreWebhookSecret: process.env.CORE_WEBHOOK_SECRET,
    integrationSyncSecret: process.env.INTEGRATION_SYNC_SECRET,
    public: {
      coreAppUrl: process.env.NUXT_PUBLIC_CORE_APP_URL || 'https://core.memudecore.com.br',
    },
  },

  devtools: {
    enabled: process.env.NODE_ENV !== 'production',
  },

  css: [
    '@core/scss/template/index.scss',
    '@styles/styles.scss',
    '@/plugins/iconify/icons.css',
    '@layouts/styles/index.scss',
  ],

  components: {
    dirs: [{
      path: '@/@core/components',
      pathPrefix: false,
    }, {
      path: '~/components/global',
      global: true,
    }, {
      path: '~/components',
      pathPrefix: false,
    }],
  },

  plugins: ['@/plugins/vuetify/index.ts', '@/plugins/iconify/index.ts'],

  imports: {
    dirs: ['./@core/utils', './@core/composable/', './plugins/*/composables/*'],
  },

  hooks: {},

  experimental: {
    typedPages: true,
  },

  typescript: {
    tsConfig: {
      compilerOptions: {
        paths: {
          '@/*': ['../*'],
          '@layouts/*': ['../@layouts/*'],
          '@layouts': ['../@layouts'],
          '@core/*': ['../@core/*'],
          '@core': ['../@core'],
          '@images/*': ['../assets/images/*'],
          '@styles/*': ['../styles/*'],
        },
      },
    },
  },

  // ℹ️ Disable source maps until this is resolved: https://github.com/vuetifyjs/vuetify-loader/issues/290
  sourcemap: {
    server: false,
    client: false,
  },

  vue: {
    compilerOptions: {
      isCustomElement: tag => tag === 'swiper-container' || tag === 'swiper-slide',
    },
  },

  vite: {
    define: { 'process.env': {} },

    resolve: {
      alias: {
        '@': fileURLToPath(new URL('.', import.meta.url)),
        '@core': fileURLToPath(new URL('./@core', import.meta.url)),
        '@layouts': fileURLToPath(new URL('./@layouts', import.meta.url)),
        '@images': fileURLToPath(new URL('./assets/images/', import.meta.url)),
        '@styles': fileURLToPath(new URL('./assets/styles/', import.meta.url)),
        '@configured-variables': fileURLToPath(new URL('./assets/styles/variables/_template.scss', import.meta.url)),
      },
    },

    build: {
      chunkSizeWarningLimit: 600,
    },

    optimizeDeps: {
      exclude: ['vuetify'],
      entries: [
        './**/*.vue',
      ],
    },

    plugins: [
      svgLoader(),
      vuetify({
        styles: {
          configFile: 'assets/styles/variables/_vuetify.scss',
        },
      }),
    ],
  },

  build: {
    transpile: ['vuetify'],
  },

  modules: ['@vueuse/nuxt', '@nuxtjs/device', '@pinia/nuxt', '@nuxtjs/supabase'],

  // Supabase: desligamos o redirect automático do módulo — a proteção de rotas
  // é feita pelo middleware da própria aplicação (stores/app + auth guard).
  supabase: {
    redirect: false,
  },

  compatibilityDate: '2025-01-01',
})
