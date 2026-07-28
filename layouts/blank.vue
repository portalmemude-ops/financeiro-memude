<template>
  <div
    class="layout-wrapper layout-blank"
    data-allow-mismatch
  >
    <slot />
  </div>
</template>

<style lang="scss">
.layout-wrapper.layout-blank {
  flex-direction: column;
}

@media (max-width: 599.98px) {
  .layout-wrapper.layout-blank .v-btn {
    min-block-size: 2.75rem;
  }

  .layout-wrapper.layout-blank .v-btn.v-btn--icon {
    block-size: 2.75rem !important;
    inline-size: 2.75rem !important;
  }

  .layout-wrapper.layout-blank a {
    align-items: center;
    min-block-size: 2.75rem;
  }

  .layout-wrapper.layout-blank .v-field__append-inner {
    align-items: center;
    min-block-size: 2.75rem;
    min-inline-size: 2.75rem;
  }
}
</style>
