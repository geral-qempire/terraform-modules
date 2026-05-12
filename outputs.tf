output "fqdn_rule_names" {
  description = "Names of the FQDN outbound rules created."
  value       = keys(local.fqdn_outbound_rules)
}

output "pe_rule_ids" {
  description = "Resource IDs of the private endpoint outbound rules."
  value       = [for r in azapi_resource.pe_rules : r.id]
}
