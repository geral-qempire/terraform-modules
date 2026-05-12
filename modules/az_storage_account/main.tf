resource "random_string" "suffix" {
  length  = 4
  lower   = true
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_storage_account" "this" {
  name                            = "${var.name}${random_string.suffix.result}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  account_kind                    = "StorageV2"
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = var.public_network_access_enabled
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  is_hns_enabled                  = var.is_hns_enabled

  identity {
    type = "SystemAssigned"
  }

  network_rules {
    default_action = var.network_default_action
    bypass         = var.network_bypass
    ip_rules       = var.network_ip_rules
  }

  tags = var.tags
}
