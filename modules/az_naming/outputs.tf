output "location_short" {
  description = "Short code for the Azure region."
  value       = local.location_short
}

output "name_suffix" {
  description = "Common name suffix: project-env-region."
  value       = local.name_suffix
}

output "resource_names" {
  description = "Map of CAF-aligned resource names."
  value       = local.resource_names
}
