resource "azurerm_storage_account" "this" {
  name                              = var.name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = var.account_tier
  account_replication_type          = var.account_replication_type
  account_kind                      = var.account_kind
  access_tier                       = var.access_tier
  min_tls_version                   = var.min_tls_version
  public_network_access_enabled     = var.public_network_access_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  tags                              = var.tags

  network_rules {
    default_action = var.network_rules_default_action
    bypass         = var.network_rules_bypass
    ip_rules       = var.network_rules_ip_rules
  }

  blob_properties {
    versioning_enabled       = var.blob_versioning_enabled
    last_access_time_enabled = var.blob_last_access_time_enabled

    dynamic "delete_retention_policy" {
      for_each = var.blob_delete_retention_days != null ? [var.blob_delete_retention_days] : []
      content {
        days = delete_retention_policy.value
      }
    }

    dynamic "container_delete_retention_policy" {
      for_each = var.container_delete_retention_days != null ? [var.container_delete_retention_days] : []
      content {
        days = container_delete_retention_policy.value
      }
    }
  }

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }
}

resource "azapi_update_resource" "geo_priority_replication" {
  count       = var.enable_geo_priority_replication ? 1 : 0
  type        = "Microsoft.Storage/storageAccounts@2025-06-01"
  resource_id = azurerm_storage_account.this.id

  body = {
    properties = {
      geoPriorityReplicationStatus = {
        isBlobEnabled = true
      }
    }
  }

  depends_on = [azurerm_storage_account.this]
}

resource "azurerm_storage_management_policy" "this" {
  count              = length(var.lifecycle_management_policy_rules) > 0 ? 1 : 0
  storage_account_id = azurerm_storage_account.this.id

  dynamic "rule" {
    for_each = var.lifecycle_management_policy_rules
    content {
      name    = rule.value.name
      enabled = true

      filters {
        blob_types   = coalesce(rule.value.filters.blob_types, ["blockBlob"])
        prefix_match = coalesce(rule.value.filters.prefix_match, [])
      }

      actions {
        dynamic "version" {
          for_each = lookup(rule.value.actions, "version", null) != null ? [lookup(rule.value.actions, "version", null)] : []
          content {
            change_tier_to_cool_after_days_since_creation = lookup(version.value, "change_tier_to_cool_after_days_since_creation", null)
            delete_after_days_since_creation              = lookup(version.value, "delete_after_days_since_creation", null)
          }
        }

        dynamic "base_blob" {
          for_each = lookup(rule.value.actions, "base_blob", null) != null ? [lookup(rule.value.actions, "base_blob", null)] : []
          content {
            auto_tier_to_hot_from_cool_enabled                             = lookup(base_blob.value, "auto_tier_to_hot_from_cool_enabled", false)
            tier_to_cool_after_days_since_last_access_time_greater_than    = lookup(base_blob.value, "tier_to_cool_after_days_since_last_access_time_greater_than", null)
            tier_to_cold_after_days_since_last_access_time_greater_than    = lookup(base_blob.value, "tier_to_cold_after_days_since_last_access_time_greater_than", null)
            tier_to_archive_after_days_since_last_access_time_greater_than = lookup(base_blob.value, "tier_to_archive_after_days_since_last_access_time_greater_than", null)
            delete_after_days_since_last_access_time_greater_than          = lookup(base_blob.value, "delete_after_days_since_last_access_time_greater_than", null)
          }
        }
      }
    }
  }
}

