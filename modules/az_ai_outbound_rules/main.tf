########################################
# FQDN outbound rules (native azurerm)
########################################

resource "azurerm_machine_learning_workspace_network_outbound_rule_fqdn" "this" {
  for_each = toset(var.fqdn_rules)

  name             = "fqdn-${replace(each.value, "/[^A-Za-z0-9]/", "-")}"
  workspace_id     = var.workspace_id
  destination_fqdn = each.value
}

########################################
# Private endpoint outbound rules (azapi)
# Uses azapi because the native azurerm resource
# only supports a limited set of sub_resource_targets.
########################################

resource "azapi_resource" "pe_rules" {
  for_each = var.private_endpoint_rules

  type                      = "Microsoft.MachineLearningServices/workspaces/outboundRules@2024-10-01"
  name                      = each.key
  parent_id                 = var.workspace_id
  schema_validation_enabled = false
  locks                     = [var.workspace_id]

  body = {
    properties = {
      type     = "PrivateEndpoint"
      category = "UserDefined"
      status   = "Active"
      destination = {
        serviceResourceId = each.value.service_resource_id
        subresourceTarget = each.value.subresource_target
        sparkEnabled      = each.value.spark_enabled
      }
    }
  }
}
