output "private_endpoint_name" {
  description = "The name of the private endpoint."
  value       = azurerm_private_endpoint.this.name
}

output "network_interface_name" {
  description = "The name of the network interface associated with the private endpoint."
  value       = try(azurerm_private_endpoint.this.network_interface[0].name, azurerm_private_endpoint.this.custom_network_interface_name)
}

output "private_endpoint_id" {
  description = "The ID of the private endpoint."
  value       = azurerm_private_endpoint.this.id
}

output "network_interface_id" {
  description = "The ID of the network interface associated with the private endpoint."
  value       = try(azurerm_private_endpoint.this.network_interface[0].id, null)
}

