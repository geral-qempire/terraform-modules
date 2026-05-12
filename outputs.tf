output "id" {
  description = "Resource ID of the AI Hub workspace."
  value       = azurerm_machine_learning_workspace.this.id
}

output "name" {
  description = "Name of the AI Hub workspace."
  value       = azurerm_machine_learning_workspace.this.name
}

output "principal_id" {
  description = "Principal ID of the system-assigned managed identity."
  value       = azurerm_machine_learning_workspace.this.identity[0].principal_id
}

output "workspace_id" {
  description = "Immutable workspace ID (GUID)."
  value       = azurerm_machine_learning_workspace.this.workspace_id
}
