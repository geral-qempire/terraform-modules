output "id" {
  description = "Resource ID of the workspace connection."
  value       = azapi_resource.this.id
}

output "name" {
  description = "Name of the workspace connection."
  value       = azapi_resource.this.name
}
