output "fqdn_rule_ids" {
  description = "Map of FQDN outbound rule IDs."
  value       = { for k, v in azapi_resource.fqdn_rules : k => v.id }
}

output "pe_rule_ids" {
  description = "Map of private endpoint outbound rule IDs."
  value       = { for k, v in azapi_resource.pe_rules : k => v.id }
}
