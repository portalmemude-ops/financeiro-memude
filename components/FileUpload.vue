<script setup lang="ts">
import { useAppStore } from '@/stores/app'

const props = withDefaults(defineProps<{
  modelValue?: string
  label?: string
  accept?: string
  entityType: 'payable' | 'receivable' | 'invoice' | 'supplier' | 'employee'
  entityId: string
}>(), {
  label: 'Anexo (comprovante)',
  accept: 'image/png,image/jpeg,application/pdf',
})

const emit = defineEmits<{ 'update:modelValue': [string | undefined] }>()
const app = useAppStore()
const supabase = useSupabaseClient() as any
const file = ref<File | File[] | null>(null)
const loading = ref(false)
const error = ref('')
const signedUrl = ref('')
const allowedTypes = new Set(['image/png', 'image/jpeg', 'application/pdf'])

async function refreshSignedUrl(path?: string) {
  signedUrl.value = ''
  if (!path)
    return
  const { data } = await supabase.storage.from('financial-attachments').createSignedUrl(path, 300)

  signedUrl.value = data?.signedUrl ?? ''
}

watch(() => props.modelValue, refreshSignedUrl, { immediate: true })

watch(file, async selected => {
  const single = Array.isArray(selected) ? selected[0] : selected
  if (!single) {
    emit('update:modelValue', undefined)

    return
  }

  error.value = ''
  if (!allowedTypes.has(single.type)) {
    error.value = 'Tipo de arquivo não permitido.'
    file.value = null

    return
  }
  if (single.size > 10 * 1024 * 1024) {
    error.value = 'O arquivo deve ter no máximo 10 MB.'
    file.value = null

    return
  }

  loading.value = true
  try {
    const extension = single.name.split('.').pop()?.toLowerCase() || 'bin'
    const path = `${app.currentCompanyId}/${props.entityType}/${props.entityId}/${crypto.randomUUID()}.${extension}`
    const digest = await crypto.subtle.digest('SHA-256', await single.arrayBuffer())
    const sha256 = Array.from(new Uint8Array(digest), byte => byte.toString(16).padStart(2, '0')).join('')

    const { error: uploadError } = await supabase.storage
      .from('financial-attachments')
      .upload(path, single, { upsert: false, contentType: single.type })

    if (uploadError)
      throw uploadError

    const user = useSupabaseUser()

    const { error: metadataError } = await supabase.from('attachments').insert({
      company_id: app.currentCompanyId,
      entity_type: props.entityType,
      entity_id: props.entityId,
      object_path: path,
      original_name: single.name,
      mime_type: single.type,
      size_bytes: single.size,
      sha256,
      uploaded_by: user.value?.id,
    })

    if (metadataError) {
      await supabase.storage.from('financial-attachments').remove([path])
      throw metadataError
    }

    emit('update:modelValue', path)
    await refreshSignedUrl(path)
  }
  catch (caught) {
    error.value = (caught as Error).message
  }
  finally {
    loading.value = false
  }
})
</script>

<template>
  <div>
    <VFileInput
      v-model="file"
      :label="label"
      :accept="accept"
      :loading="loading"
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
    <a
      v-if="signedUrl"
      :href="signedUrl"
      target="_blank"
      rel="noopener noreferrer"
      class="text-caption text-primary"
    >
      Ver anexo atual
    </a>
  </div>
</template>
