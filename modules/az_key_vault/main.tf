resource "random_string" "suffix" {
  length  = 4
  lower   = true
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_key_vault" "this" {
  name                          = "${var.name}${random_string.suffix.result}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = var.sku_name
  rbac_authorization_enabled    = true
  public_network_access_enabled = var.public_network_access_enabled
  purge_protection_enabled      = var.purge_protection_enabled
  soft_delete_retention_days    = var.soft_delete_retention_days

  network_acls {
    default_action = var.network_default_action
    bypass         = var.network_bypass
    ip_rules       = var.network_ip_rules
  }

  tags = var.tags
}
