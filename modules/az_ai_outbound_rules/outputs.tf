output "fqdn_rule_ids" {
  description = "Map of FQDN outbound rule IDs."
  value       = { for k, v in azurerm_machine_learning_workspace_network_outbound_rule_fqdn.this : k => v.id }
}

output "pe_rule_ids" {
  description = "Map of private endpoint outbound rule IDs."
  value       = { for k, v in azurerm_machine_learning_workspace_network_outbound_rule_private_endpoint.this : k => v.id }
}
