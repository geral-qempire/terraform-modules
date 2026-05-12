resource "azurerm_mssql_server" "this" {
  name                          = var.server_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  version                       = "12.0"
  minimum_tls_version           = var.min_tls_version
  public_network_access_enabled = var.public_network_access_enabled

  azuread_administrator {
    login_username              = var.azuread_administrator.login_username
    object_id                   = var.azuread_administrator.object_id
    azuread_authentication_only = var.azuread_administrator.azuread_authentication_only
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_mssql_database" "this" {
  name        = var.database_name
  server_id   = azurerm_mssql_server.this.id
  sku_name    = var.sku_name
  max_size_gb = var.max_size_gb

  tags = var.tags
}
