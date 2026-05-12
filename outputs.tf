output "id" {
  description = "Resource ID of the AI Project workspace."
  value       = azapi_resource.this.id
}

output "name" {
  description = "Name of the AI Project workspace."
  value       = azapi_resource.this.name
}

output "principal_id" {
  description = "Principal ID of the system-assigned managed identity."
  value       = azapi_resource.this.identity[0].principal_id
}
