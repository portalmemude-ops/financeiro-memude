# Core sales synchronization recovery (2026-09-23)

The deployed Core exporter and Finance worker diverged from source and used a placeholder credential. Incoming webhooks reached Finance, but its Core reads returned 401.

Exports now use timestamped HMAC-SHA256 over the exact request body (five-minute tolerance). The existing webhook signing credential is provisioned in Finance Vault as core_signed_export_secret. Only service_role can execute get_core_sync_config; never put its returned secret in logs or client configuration.

Deploy order: Finance migration, provision Vault credential, Core finance-export, Finance core-sync, Core reconciliation cron, Finance app image. Existing sale/deletion webhooks remain on the app endpoint. The independent reconciliation runs every five minutes and upserts by company_id + core_venda_id, recovering missed events without deleting retained Finance history. The app uses the same signed export after redeployment.

Buyer identity and complete source sale payload are retained. Core sale payment status controls commission status; an expected payment date alone never marks a commission received. Registered sales are completed unless cancelled. Reference lookups and Core exports paginate in stable ID order.

Validation: pnpm verify; production reconciliation returned HTTP 200, imported Sanderson's sale, and repeated synchronization kept one sale and one commission. Confirmed amount 284000, correct buyer/development/broker, commission pending, expected payment 2026-10-31. Unsigned requests to both Edge endpoints return 401; anonymous/authenticated roles cannot read the credential RPC.

After publishing the GHCR image, redeploy the Finance container. Verify integration_sync_state.last_success_at and integration_events after a signed app webhook. Never create fake production sales to test.
