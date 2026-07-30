import { defineStore } from 'pinia'
import { useAppStore } from './app'
import type { AuditEntry } from '@/types/finance'

// ============================================================================
// A fonte de verdade é audit_log, preenchida por triggers do PostgreSQL.
// ============================================================================

export const useAuditStore = defineStore('audit', {
  state: () => ({
    entries: [] as AuditEntry[],
  }),

  getters: {
    companyEntries(state): AuditEntry[] {
      const app = useAppStore()

      return state.entries
        .filter(e => e.companyId === app.currentCompanyId)
        .sort((a, b) => b.createdAt.localeCompare(a.createdAt))
    },
  },

  actions: {
    async load() {
      const app = useAppStore()
      if (!app.currentCompanyId)
        return
      const supabase = useSupabaseClient() as any

      const { data, error } = await supabase
        .from('audit_log')
        .select('id, company_id, actor_id, action, entity_type, entity_id, old_data, new_data, created_at')
        .eq('company_id', app.currentCompanyId)
        .order('created_at', { ascending: false })
        .limit(500)

      if (error)
        throw new Error(error.message)
      this.entries = (data ?? []).map((row: Record<string, any>) => ({
        id: String(row.id),
        companyId: row.company_id,
        userId: row.actor_id ?? '',
        userName: row.actor_id === app.currentUserId ? app.currentUser.fullName : 'Usuário do sistema',
        action: row.action,
        entityType: row.entity_type,
        entityId: row.entity_id ?? undefined,
        description: `${row.action} em ${row.entity_type}`,
        createdAt: row.created_at,
      }))
    },

    reset() {
      this.entries = []
    },

    /** Entrada transitória; a confirmação durável vem do trigger no reload. */
    record(action: string, entityType: string, description: string, entityId?: string) {
      const app = useAppStore()

      this.entries.unshift({
        id: uid('aud'),
        companyId: app.currentCompanyId,
        userId: app.currentUserId,
        userName: app.currentUser.fullName,
        action,
        entityType,
        entityId,
        description,
        createdAt: new Date().toISOString(),
      })
    },
  },
})
