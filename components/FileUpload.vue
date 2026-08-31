<script setup lang="ts">
import { useAppStore } from '@/stores/app'

const props = withDefaults(defineProps<{
  modelValue?: string
  label?: string
  accept?: string
  entityType: 'payable' | 'receivable' | 'invoice' | 'supplier' | 'employee'
  entityId?: string
  autoUpload?: boolean
  hint?: string
  persistentHint?: boolean
}>(), {
  label: 'Anexo (comprovante)',
  accept: 'image/png,image/jpeg,application/pdf',
  entityId: '',
  autoUpload: true,
  hint: '',
  persistentHint: false,
})

const emit = defineEmits<{
  'update:modelValue': [string | undefined]
  'deleted': []
}>()
const app = useAppStore()
const file = ref<File | File[] | null>(null)
const loading = ref(false)
const error = ref('')
const allowedTypes = new Set(['image/png', 'image/jpeg', 'application/pdf'])

const currentHref = computed(() => {
  if (!props.modelValue)
    return ''
  if (props.modelValue.startsWith('http') || props.modelValue.startsWith('/'))
    return props.modelValue

  return `/api/storage/legacy/download?companyId=${encodeURIComponent(app.currentCompanyId)}&path=${encodeURIComponent(props.modelValue)}`
})

/**
 * Só dá para excluir anexo enviado por dentro do sistema, que tem registro
 * próprio. Link externo colado à mão e caminho antigo não têm o que apagar.
 */
const attachmentId = computed(() => {
  const match = /^\/api\/storage\/attachments\/([0-9a-f-]{36})\/download$/.exec(props.modelValue ?? '')

  return match?.[1] ?? ''
})

const canDelete = computed(() =>
  Boolean(attachmentId.value) && ['super_admin', 'admin'].includes(app.currentRole),
)

const deleting = ref(false)
const confirmDelete = ref(false)

async function removeAttachment() {
  if (!attachmentId.value)
    return
  deleting.value = true
  error.value = ''
  try {
    await $fetch(`/api/storage/attachments/${attachmentId.value}`, { method: 'DELETE' })
    emit('update:modelValue', '')
    emit('deleted')
    confirmDelete.value = false
  }
  catch (caught) {
    error.value = uploadErrorMessage(caught)
  }
  finally {
    deleting.value = false
  }
}

function selectedFile() {
  return Array.isArray(file.value) ? file.value[0] : file.value
}

function validate(single?: File) {
  error.value = ''
  if (!single)
    return false
  if (!allowedTypes.has(single.type)) {
    error.value = 'Tipo de arquivo não permitido. Envie PDF, PNG ou JPEG.'

    return false
  }
  if (single.size > 10 * 1024 * 1024) {
    error.value = 'O arquivo deve ter no máximo 10 MB.'

    return false
  }

  return true
}

/**
 * O $fetch embrulha a falha e sua `message` vira só `[POST] "/api/...": 500`,
 * escondendo o motivo real que o servidor devolveu em `data.message`. Sem isso
 * o usuário via um código de erro e nada mais.
 */
function uploadErrorMessage(caught: unknown): string {
  const fromServer = (caught as { data?: { message?: string; statusMessage?: string } })?.data

  return fromServer?.message
    || fromServer?.statusMessage
    || (caught instanceof Error ? caught.message : '')
    || 'Não foi possível enviar o anexo.'
}

async function upload(entityId = props.entityId) {
  const single = selectedFile()
  if (!single)
    return props.modelValue
  if (!validate(single))
    throw new Error(error.value)
  if (!entityId)
    throw new Error('Salve o registro antes de enviar o anexo.')

  loading.value = true
  try {
    const body = new FormData()

    body.append('companyId', app.currentCompanyId)
    body.append('entityType', props.entityType)
    body.append('entityId', entityId)
    body.append('file', single)

    const result = await $fetch<{ reference: string }>('/api/storage/upload', { method: 'POST', body })

    emit('update:modelValue', result.reference)
    file.value = null

    return result.reference
  }
  catch (caught) {
    error.value = uploadErrorMessage(caught)
    throw caught
  }
  finally {
    loading.value = false
  }
}

watch(file, async value => {
  const single = Array.isArray(value) ? value[0] : value
  if (!single) {
    error.value = ''

    return
  }
  if (!validate(single)) {
    file.value = null

    return
  }
  if (props.autoUpload) {
    try {
      await upload()
    }
    catch {
      // upload() already exposes the actionable error in the component.
    }
  }
})

defineExpose({ upload, hasPendingFile: () => Boolean(selectedFile()) })
</script>

<template>
  <div>
    <VFileInput
      v-model="file"
      :label="label"
      :accept="accept"
      :loading="loading"
      :hint="hint"
      :persistent-hint="persistentHint"
      prepend-icon="ri-attachment-2"
      density="compact"
      show-size
      clearable
    />
    <VAlert
      v-if="error"
      type="error"
      variant="tonal"
      density="compact"
      class="mb-2"
      :text="error"
    />
    <div
      v-if="currentHref"
      class="d-flex align-center gap-3"
    >
      <a
        :href="currentHref"
        target="_blank"
        rel="noopener noreferrer"
        class="text-caption text-primary"
      >
        Ver anexo atual
      </a>
      <VBtn
        v-if="canDelete"
        size="x-small"
        variant="text"
        color="error"
        prepend-icon="ri-delete-bin-line"
        :loading="deleting"
        @click="confirmDelete = true"
      >
        Excluir anexo
      </VBtn>
    </div>

    <ConfirmDialog
      v-model="confirmDelete"
      title="Excluir anexo"
      message="O arquivo será apagado em definitivo e desvinculado desta conta. Boletos e comprovantes são documentos de respaldo fiscal — esta ação não pode ser desfeita. Deseja continuar?"
      confirm-text="Excluir"
      confirm-color="error"
      @confirm="removeAttachment"
    />
  </div>
</template>
