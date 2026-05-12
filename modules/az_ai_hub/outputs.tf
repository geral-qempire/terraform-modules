output "id" {
  description = "Resource ID of the AI Foundry Hub."
  value       = azurerm_ai_foundry.this.id
}

output "name" {
  description = "Name of the AI Foundry Hub."
  value       = azurerm_ai_foundry.this.name
}

output "principal_id" {
  description = "Principal ID of the system-assigned managed identity."
  value       = azurerm_ai_foundry.this.identity[0].principal_id
}

output "workspace_id" {
  description = "Immutable workspace ID."
  value       = azurerm_ai_foundry.this.workspace_id
}
