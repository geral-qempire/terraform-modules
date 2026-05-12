locals {
  fqdn_outbound_rules = {
    for fqdn in var.fqdn_rules : "fqdn-${replace(fqdn, "/[^A-Za-z0-9]/", "-")}" => {
      category    = "UserDefined"
      status      = "Active"
      type        = "FQDN"
      destination = fqdn
    }
  }

  pe_rule_keys = keys(var.private_endpoint_rules)
}

# Bulk-add all FQDN outbound rules in a single update to avoid sequential conflicts
resource "azapi_update_resource" "fqdn_rules" {
  count = length(var.fqdn_rules) > 0 ? 1 : 0

  type        = "Microsoft.MachineLearningServices/workspaces@2024-10-01"
  resource_id = var.workspace_id

  body = {
    properties = {
      managedNetwork = {
        outboundRules = local.fqdn_outbound_rules
      }
    }
  }
}

# Private endpoint outbound rules must be provisioned sequentially.
# Each rule creates a managed private endpoint in the Azure-managed VNet.
resource "azapi_resource" "pe_rules" {
  count = length(local.pe_rule_keys)

  type                      = "Microsoft.MachineLearningServices/workspaces/outboundRules@2024-10-01"
  name                      = local.pe_rule_keys[count.index]
  parent_id                 = var.workspace_id
  schema_validation_enabled = false

  body = {
    type = "PrivateEndpoint"
    properties = {
      category = "UserDefined"
      status   = "Active"
      destination = {
        serviceResourceId = var.private_endpoint_rules[local.pe_rule_keys[count.index]].service_resource_id
        subresourceTarget = var.private_endpoint_rules[local.pe_rule_keys[count.index]].subresource_target
        sparkEnabled      = var.private_endpoint_rules[local.pe_rule_keys[count.index]].spark_enabled
      }
    }
  }

  depends_on = [
    azapi_resource.pe_rules
  ]
}
