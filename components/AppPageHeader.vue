<script setup lang="ts">
interface Props {
  title: string
  subtitle?: string
  icon?: string
}
defineProps<Props>()
</script>

<template>
  <div class="app-page-header d-flex flex-wrap justify-space-between align-center gap-4 mb-6">
    <div class="app-page-header__identity d-flex align-center gap-x-3">
      <VAvatar
        v-if="icon"
        rounded
        variant="tonal"
        color="primary"
        size="42"
      >
        <VIcon
          :icon="icon"
          size="24"
        />
      </VAvatar>
      <div class="app-page-header__copy">
        <h4 class="app-page-header__title text-h4 mb-0">
          {{ title }}
        </h4>
        <span
          v-if="subtitle"
          class="text-body-1 text-medium-emphasis"
        >{{ subtitle }}</span>
      </div>
    </div>

    <div class="app-page-header__actions d-flex align-center gap-2">
      <slot name="actions" />
    </div>
  </div>
</template>

<style lang="scss" scoped>
.app-page-header__identity,
.app-page-header__copy {
  min-inline-size: 0;
}

.app-page-header__title {
  overflow-wrap: anywhere;
}

.app-page-header__actions {
  flex-wrap: wrap;
  max-inline-size: 100%;
}

@media (max-width: 599.98px) {
  .app-page-header {
    align-items: flex-start !important;
    gap: 0.875rem !important;
    margin-block-end: 1rem !important;
  }

  .app-page-header__identity {
    inline-size: 100%;
  }

  .app-page-header__title {
    font-size: 1.5rem !important;
    line-height: 1.9rem !important;
  }

  .app-page-header__actions {
    display: grid !important;
    grid-template-columns: repeat(auto-fit, minmax(min(100%, 9rem), 1fr));
    inline-size: 100%;
  }

  .app-page-header__actions :deep(.v-btn) {
    inline-size: 100%;
  }
}
</style>
