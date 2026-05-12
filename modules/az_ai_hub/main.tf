resource "azurerm_ai_foundry" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  storage_account_id  = var.storage_account_id
  key_vault_id        = var.key_vault_id
  application_insights_id = var.application_insights_id
  container_registry_id   = var.container_registry_id
  public_network_access   = var.public_network_access
  friendly_name           = var.friendly_name != "" ? var.friendly_name : var.name
  description             = var.description

  managed_network {
    isolation_mode = var.managed_network_isolation_mode
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
