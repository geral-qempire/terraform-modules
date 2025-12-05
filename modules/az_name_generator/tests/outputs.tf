output "name" {
  description = "The generated name following the naming convention"
  value       = module.name_generator.name
}

output "resource_abbreviation" {
  description = "The abbreviation for the resource type"
  value       = module.name_generator.resource_abbreviation
}

output "location_abbreviation" {
  description = "The abbreviation for the location"
  value       = module.name_generator.location_abbreviation
}
