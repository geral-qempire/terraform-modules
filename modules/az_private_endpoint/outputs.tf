output "id" {
  description = "Resource ID of the private endpoint."
  value       = azurerm_private_endpoint.this.id
}

output "private_ip_addresses" {
  description = "Private IP addresses assigned to the endpoint."
  value       = azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
}
