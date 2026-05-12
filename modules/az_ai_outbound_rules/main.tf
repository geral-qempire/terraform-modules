########################################
# FQDN outbound rules
########################################

resource "azurerm_machine_learning_workspace_network_outbound_rule_fqdn" "this" {
  for_each = toset(var.fqdn_rules)

  name                 = "fqdn-${replace(each.value, "/[^A-Za-z0-9]/", "-")}"
  workspace_id         = var.workspace_id
  destination_fqdn     = each.value
}

########################################
# Private endpoint outbound rules
########################################

resource "azurerm_machine_learning_workspace_network_outbound_rule_private_endpoint" "this" {
  for_each = var.private_endpoint_rules

  name                = each.key
  workspace_id        = var.workspace_id
  service_resource_id = each.value.service_resource_id
  sub_resource_target = each.value.subresource_target
  spark_enabled       = each.value.spark_enabled
}
