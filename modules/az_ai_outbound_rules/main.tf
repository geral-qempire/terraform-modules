########################################
# FQDN outbound rules (sequential with 2s delay)
# Azure deletes rules when created in parallel,
# so we chain them: time_sleep[N] -> fqdn[N] -> time_sleep[N+1] -> fqdn[N+1]
########################################

locals {
  fqdn_list = var.fqdn_rules
}

resource "time_sleep" "fqdn_delay" {
  count           = length(local.fqdn_list)
  create_duration = count.index > 0 ? "2s" : "0s"

  triggers = {
    fqdn     = local.fqdn_list[count.index]
    after_id = count.index > 0 ? azurerm_machine_learning_workspace_network_outbound_rule_fqdn.this[count.index - 1].id : ""
  }
}

resource "azurerm_machine_learning_workspace_network_outbound_rule_fqdn" "this" {
  count = length(local.fqdn_list)

  name             = "fqdn-${replace(local.fqdn_list[count.index], "/[^A-Za-z0-9]/", "-")}"
  workspace_id     = var.workspace_id
  destination_fqdn = time_sleep.fqdn_delay[count.index].triggers["fqdn"]
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
