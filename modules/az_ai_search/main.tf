resource "azurerm_search_service" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  replica_count                 = var.replica_count
  partition_count               = var.partition_count
  public_network_access_enabled = var.public_network_access_enabled
  local_authentication_enabled  = var.local_authentication_enabled
  authentication_failure_mode   = var.authentication_failure_mode

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
