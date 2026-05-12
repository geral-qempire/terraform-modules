output "id" {
  description = "Resource ID of the AI Search service."
  value       = azurerm_search_service.this.id
}

output "name" {
  description = "Name of the AI Search service."
  value       = azurerm_search_service.this.name
}

output "endpoint" {
  description = "HTTPS endpoint URL of the AI Search service."
  value       = "https://${azurerm_search_service.this.name}.search.windows.net"
}

output "principal_id" {
  description = "Principal ID of the system-assigned managed identity."
  value       = azurerm_search_service.this.identity[0].principal_id
}
