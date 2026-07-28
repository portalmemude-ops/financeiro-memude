<script lang="ts" setup>
import DefaultLayoutWithVerticalNav from './components/DefaultLayoutWithVerticalNav.vue'
</script>

<template>
  <DefaultLayoutWithVerticalNav>
    <slot />
  </DefaultLayoutWithVerticalNav>
</template>

<style lang="scss">
// As we are using `layouts` plugin we need its styles to be imported
@use "@layouts/styles/default-layout";

// ---------------------------------------------------------------------------
// Overrides globais de responsividade dos cabeçalhos de card (VCardItem).
// Ficam aqui (estilo não-scoped do layout) porque o CSS do layout é entregue
// como folha linkada ao cliente — ao contrário do css global do nuxt.config,
// que era inlinado no SSR e sumia após a navegação SPA no build de produção.
// ---------------------------------------------------------------------------

// Títulos de card (VCardTitle) vêm com `white-space: nowrap` + ellipsis no
// Vuetify, cortando títulos longos de seção. Aqui deixamos quebrar linha.
.v-card-item .v-card-title {
  white-space: normal;
  overflow: visible;
  text-overflow: unset;
}

// O cabeçalho do card usa `display: grid` no Vuetify, mantendo as ações
// (#append) na mesma coluna do título — o que estourava para fora da tela no
// mobile em cards com título longo + botões (ex.: exportações nos Relatórios).
// Abaixo de 600px trocamos para flex com quebra: título na 1ª linha, ações
// descem para a linha de baixo. A classe repetida eleva a especificidade para
// vencer a regra `display: grid` do Vuetify independente da ordem de carga.
@media (max-width: 599.98px) {
  html,
  body,
  .layout-wrapper,
  .layout-content-wrapper {
    max-inline-size: 100%;
  }

  .layout-navbar .navbar-content-container,
  .layout-page-content,
  .layout-footer .footer-content-container {
    padding-inline: 0.75rem !important;
  }

  .layout-navbar {
    padding-inline: 0 !important;
  }

  .layout-page-content {
    padding-block: 1rem !important;
  }

  .v-card-item.v-card-item {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    row-gap: 0.5rem;
  }

  .v-card-item .v-card-item__content {
    min-width: 0;
    overflow: visible;
  }

  .v-card-item .v-card-item__append {
    padding-inline-start: 0;
  }

  // Alvos tÃ¡teis: 44px Ã© o mÃ­nimo seguro para uso com o polegar.
  .layout-wrapper .v-btn {
    min-block-size: 2.75rem;
  }

  .layout-wrapper .v-btn.v-btn--icon {
    block-size: 2.75rem !important;
    inline-size: 2.75rem !important;
  }

  .layout-wrapper .v-tab {
    min-block-size: 2.75rem;
  }

  // Filtros deixam de preservar larguras desktop definidas inline.
  .layout-page-content .v-card-text.d-flex.flex-wrap > .v-input,
  .layout-page-content .v-card-text.d-flex.flex-wrap > .v-field,
  .layout-page-content .v-card-text.d-flex.flex-wrap > .v-btn-toggle {
    flex: 1 1 100%;
    max-inline-size: 100% !important;
  }

  .v-btn-toggle.v-btn-toggle {
    display: flex;
    max-inline-size: 100%;
    overflow-x: auto;
    overscroll-behavior-inline: contain;
  }

  // Modais permanecem dentro da viewport e o conteÃºdo central rola.
  .v-dialog > .v-overlay__content {
    margin: 0.75rem !important;
    max-block-size: calc(100dvh - 1.5rem) !important;
    max-inline-size: calc(100vw - 1.5rem) !important;
  }

  .v-dialog > .v-overlay__content > .v-card {
    max-block-size: calc(100dvh - 1.5rem);
    overflow-y: auto;
  }

  .v-dialog .v-card-text.d-flex.justify-end,
  .v-dialog .v-card-actions {
    flex-wrap: wrap;
    gap: 0.5rem;
  }

  // Tabelas nativas continuam acessÃ­veis por gesto horizontal, sem mover a
  // pÃ¡gina inteira. Tabelas de dados usam o modo de linhas mobile do Vuetify.
  .v-table__wrapper {
    max-inline-size: 100%;
    overscroll-behavior-inline: contain;
    scrollbar-width: thin;
  }

  .v-data-table .v-data-table__tr--mobile {
    border: 1px solid rgba(var(--v-border-color), var(--v-border-opacity));
    border-radius: 0.75rem;
    display: block;
    margin: 0.75rem;
    overflow: hidden;
  }

  .v-data-table .v-data-table__tr--mobile > td {
    align-items: flex-start;
    display: grid;
    gap: 0.75rem;
    grid-template-columns: minmax(5.5rem, 38%) minmax(0, 1fr);
    min-block-size: 2.75rem;
    padding-block: 0.625rem;
    white-space: normal;
  }

  .v-data-table .v-data-table__td-title {
    overflow-wrap: anywhere;
    white-space: normal;
  }

  .v-data-table .v-data-table-footer {
    flex-wrap: wrap;
    gap: 0.5rem;
    justify-content: center;
    padding: 0.75rem;
  }

  .v-data-table .v-data-table-footer__items-per-page,
  .v-data-table .v-data-table-footer__info {
    margin-inline: 0;
  }

  .v-slide-group {
    max-inline-size: 100%;
  }

  .v-slide-group__container {
    overscroll-behavior-inline: contain;
  }

  .v-alert,
  .v-card-text,
  .v-list-item-title,
  .v-list-item-subtitle {
    overflow-wrap: anywhere;
  }
}

@media (max-width: 399.98px) {
  .v-dialog .v-card-text.d-flex.justify-end > .v-btn,
  .v-dialog .v-card-actions > .v-btn {
    flex: 1 1 100%;
    margin-inline: 0 !important;
  }
}

// ---------------------------------------------------------------------------
// Filtros VBtnToggle com rótulos de texto (Todos/Ativos/Inativos, Fornecedor/
// Colaborador etc.). O template Materio força `inline-size` fixa (36px em
// density compact, 52px normal) em TODO `.v-btn-toggle .v-btn`, supondo toggles
// só-ícone — o que espreme os botões e SOBREPÕE os rótulos de texto. Aqui
// liberamos a largura para o conteúdo. A classe repetida eleva a especificidade
// (0,4,0) para vencer a regra `!important` do template (body ... = 0,3,1),
// independente da ordem de carga.
.v-btn-toggle.v-btn-toggle .v-btn.v-btn {
  inline-size: auto !important;
  min-inline-size: 2.75rem !important;
  padding-inline: 1rem !important;
}

// ---------------------------------------------------------------------------
// Contraste do tooltip dos gráficos (ApexCharts).
// O ApexCharts injeta o tooltip FORA do componente Vue (anexado ao
// `.apexcharts-canvas`) com o tema "light" padrão: caixa branca, mas SEM cor
// de texto explícita — o texto herda a cor da página. No modo escuro isso dá
// texto claro sobre fundo branco = ilegível. O override adaptativo do tema
// (@core/scss/.../apex-chart.scss) vem pelo `css:` array do nuxt.config, que é
// inlinado no SSR e NÃO chega ao cliente — então some na navegação SPA.
// Repetimos a regra aqui (folha do layout, entregue ao cliente) usando as
// variáveis do Vuetify, corrigindo em light e dark, em todos os gráficos.
.apexcharts-canvas {
  .apexcharts-tooltip,
  .apexcharts-tooltip.apexcharts-theme-light,
  .apexcharts-tooltip.apexcharts-theme-dark {
    border-color: rgba(var(--v-border-color), var(--v-border-opacity));
    background: rgb(var(--v-theme-surface));
    color: rgba(var(--v-theme-on-surface), var(--v-high-emphasis-opacity));
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.16);
  }

  .apexcharts-tooltip-title {
    border-color: rgba(var(--v-border-color), var(--v-border-opacity));
    background: rgb(var(--v-theme-surface));
    color: rgba(var(--v-theme-on-surface), var(--v-high-emphasis-opacity));
    font-weight: 500;
  }

  .apexcharts-tooltip-text,
  .apexcharts-tooltip-text-y-label,
  .apexcharts-tooltip-text-y-value,
  .apexcharts-tooltip-text-goals-label,
  .apexcharts-tooltip-text-goals-value,
  .apexcharts-tooltip-marker + .apexcharts-tooltip-text {
    color: rgba(var(--v-theme-on-surface), var(--v-high-emphasis-opacity));
  }

  // Tooltip dos eixos (x/y) — mesma lógica de contraste.
  .apexcharts-xaxistooltip,
  .apexcharts-yaxistooltip {
    border-color: rgba(var(--v-border-color), var(--v-border-opacity));
    background: rgb(var(--v-theme-surface));
    color: rgba(var(--v-theme-on-surface), var(--v-high-emphasis-opacity));
  }

  .apexcharts-xaxistooltip-text,
  .apexcharts-yaxistooltip-text {
    color: rgba(var(--v-theme-on-surface), var(--v-high-emphasis-opacity));
  }

  // As "setinhas" (arrows) dos tooltips de eixo herdam a cor de fundo.
  .apexcharts-xaxistooltip-bottom::before {
    border-bottom-color: rgba(var(--v-border-color), var(--v-border-opacity));
  }

  .apexcharts-xaxistooltip-bottom::after {
    border-bottom-color: rgb(var(--v-theme-surface));
  }
}
</style>
