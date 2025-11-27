# Resolve subnet when only names are provided
locals {
  vnet_resource_group = coalesce(var.virtual_network_resource_group_name, var.resource_group_name)
}

data "azurerm_subnet" "selected" {
  count = var.subnet_id == null ? 1 : 0

  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = local.vnet_resource_group
}

locals {
  resolved_subnet_id = coalesce(var.subnet_id, try(data.azurerm_subnet.selected[0].id, null))
}

# Data sources for private DNS zones
data "azurerm_private_dns_zone" "this" {
  provider            = azurerm.dns
  for_each            = toset(var.private_dns_zones)
  name                = each.value
  resource_group_name = var.dns_resource_group_name
}

# Private endpoint resource
resource "azurerm_private_endpoint" "this" {
  location                      = var.private_endpoint_location != "" ? var.private_endpoint_location : var.location
  name                          = var.name
  resource_group_name           = var.resource_group_name
  subnet_id                     = local.resolved_subnet_id
  custom_network_interface_name = "nic-${var.name}"
  tags                          = var.tags

  private_service_connection {
    is_manual_connection           = var.is_manual_connection
    name                           = "psc-${var.name}"
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.subresource_names
  }

  dynamic "private_dns_zone_group" {
    for_each = length(var.private_dns_zones) > 0 ? [1] : []
    content {
      name                 = "default"
      private_dns_zone_ids = [for zone in data.azurerm_private_dns_zone.this : zone.id]
    }
  }
}

