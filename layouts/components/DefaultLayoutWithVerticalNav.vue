<script lang="ts" setup>
import NavItems from '@/layouts/components/NavItems.vue'
import brandLogoUrl from '@images/brand-full.svg?url'
import VerticalNavLayout from '@layouts/components/VerticalNavLayout.vue'

// Components
import Footer from '@/layouts/components/Footer.vue'
import NavbarThemeSwitcher from '@/layouts/components/NavbarThemeSwitcher.vue'
import UserProfile from '@/layouts/components/UserProfile.vue'
import CompanySelector from '@/layouts/components/CompanySelector.vue'
import NavbarNotifications from '@/layouts/components/NavbarNotifications.vue'
import CashBalanceBadge from '@/layouts/components/CashBalanceBadge.vue'
import QuickAddMenu from '@/layouts/components/QuickAddMenu.vue'
</script>

<template>
  <VerticalNavLayout>
    <!-- 👉 navbar -->
    <template #navbar="{ toggleVerticalOverlayNavActive }">
      <div class="mobile-navbar d-flex h-100 align-center">
        <!-- 👉 Vertical nav toggle in overlay mode -->
        <IconBtn
          class="ms-n3 d-lg-none"
          aria-label="Abrir menu de navegação"
          @click="toggleVerticalOverlayNavActive(true)"
        >
          <VIcon icon="ri-menu-line" />
        </IconBtn>

        <!-- 👉 Seletor de empresa (multi-tenant) -->
        <CompanySelector />

        <!-- 👉 Saldo em caixa — sempre visível -->
        <CashBalanceBadge class="ms-4 d-none d-sm-flex" />

        <!-- 👉 Botão global de adicionar (atalhos rápidos) -->
        <QuickAddMenu class="mobile-navbar__quick-add ms-3" />

        <VSpacer />

        <NavbarNotifications class="me-1" />

        <NavbarThemeSwitcher class="mobile-navbar__theme me-2" />

        <UserProfile />
      </div>
    </template>

    <template #vertical-nav-header="{ toggleIsOverlayNavActive }">
      <NuxtLink
        to="/"
        class="app-logo app-title-wrapper"
        aria-label="Ir para o dashboard do Portal MeMude"
      >
        <img
          :src="brandLogoUrl"
          class="app-logo__brand"
          alt="Portal MeMude"
        >
      </NuxtLink>

      <IconBtn
        class="d-block d-lg-none"
        aria-label="Fechar menu de navegação"
        @click="toggleIsOverlayNavActive(false)"
      >
        <VIcon icon="ri-close-line" />
      </IconBtn>
    </template>

    <template #vertical-nav-content>
      <NavItems />
    </template>

    <!-- 👉 Pages -->
    <slot />

    <!-- 👉 Footer -->
    <template #footer>
      <Footer />
    </template>
  </VerticalNavLayout>
</template>

<style lang="scss" scoped>
.meta-key {
  border: thin solid rgba(var(--v-border-color), var(--v-border-opacity));
  border-radius: 6px;
  block-size: 1.5625rem;
  line-height: 1.3125rem;
  padding-block: 0.125rem;
  padding-inline: 0.25rem;
}

.app-logo {
  display: flex;
  align-items: center;
  min-inline-size: 0;
}

.app-logo__brand {
  display: block;
  block-size: 3.25rem;
  inline-size: auto;
  max-inline-size: 10rem;
  object-fit: contain;
  object-position: left center;
}

@media (max-width: 599.98px) {
  .app-logo__brand {
    block-size: 2.875rem;
  }

  .mobile-navbar {
    gap: 0.125rem;
    inline-size: 100%;
  }

  .mobile-navbar :deep(.v-btn--icon) {
    margin-inline: 0 !important;
  }

  .mobile-navbar__quick-add {
    margin-inline-start: 0 !important;
  }

  .mobile-navbar__theme {
    margin-inline-end: 0 !important;
  }
}
</style>
