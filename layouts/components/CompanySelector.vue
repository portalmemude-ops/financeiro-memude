<script setup lang="ts">
import { useDisplay } from 'vuetify'
import { useAppStore } from '@/stores/app'

const appStore = useAppStore()
const { xs } = useDisplay()
const companyIcon = computed(() => appStore.isRealEstate ? 'ri-building-line' : 'ri-megaphone-line')
</script>

<template>
  <VBtn
    variant="tonal"
    color="default"
    class="company-selector text-none"
    :icon="xs"
    :prepend-icon="xs ? undefined : companyIcon"
    :append-icon="xs || appStore.availableCompanies.length === 1 ? undefined : 'ri-arrow-down-s-line'"
    :aria-label="xs ? `Selecionar empresa. Atual: ${appStore.currentCompany.tradeName}` : undefined"
  >
    <VIcon
      v-if="xs"
      :icon="companyIcon"
    />
    <span v-else>{{ appStore.currentCompany.tradeName }}</span>

    <VMenu
      v-if="appStore.availableCompanies.length > 1"
      activator="parent"
      location="bottom end"
      offset="8"
    >
      <VList
        class="company-selector__menu"
        density="comfortable"
      >
        <VListSubheader>Empresas</VListSubheader>
        <VListItem
          v-for="company in appStore.availableCompanies"
          :key="company.id"
          :active="company.id === appStore.currentCompanyId"
          @click="appStore.setCompany(company.id)"
        >
          <template #prepend>
            <VAvatar
              size="34"
              rounded
              variant="tonal"
              :color="company.logoColor"
            >
              <VIcon :icon="company.type === 'real_estate' ? 'ri-building-line' : 'ri-megaphone-line'" />
            </VAvatar>
          </template>
          <VListItemTitle class="font-weight-medium">
            {{ company.tradeName }}
          </VListItemTitle>
          <VListItemSubtitle>{{ company.type === 'real_estate' ? 'Imobiliária' : 'Agência' }}</VListItemSubtitle>
          <template #append>
            <VIcon
              v-if="company.id === appStore.currentCompanyId"
              icon="ri-check-line"
              color="primary"
            />
          </template>
        </VListItem>
      </VList>
    </VMenu>
  </VBtn>
</template>

<style lang="scss" scoped>
.company-selector {
  max-inline-size: min(18rem, 35vw);
}

.company-selector__menu {
  inline-size: min(17.5rem, calc(100vw - 1.5rem));
}

@media (max-width: 599.98px) {
  .company-selector {
    block-size: 2.75rem !important;
    inline-size: 2.75rem !important;
    max-inline-size: 2.75rem;
  }
}
</style>
