locals {
  fqdn_outbound_rules = {
    for fqdn in var.fqdn_rules : "fqdn-${replace(fqdn, "/[^A-Za-z0-9]/", "-")}" => {
      category    = "UserDefined"
      status      = "Active"
      type        = "FQDN"
      destination = fqdn
    }
  }

  pe_rule_list = [
    for name, rule in var.private_endpoint_rules : {
      name                = name
      service_resource_id = rule.service_resource_id
      subresource_target  = rule.subresource_target
      spark_enabled       = rule.spark_enabled
    }
  ]
}

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

# Private endpoint outbound rules provisioned via managed PE in the hub VNet.
# Azure ARM serializes these on the backend; parallel Terraform creation is safe.
resource "azapi_resource" "pe_rules" {
  count = length(local.pe_rule_list)

  type                      = "Microsoft.MachineLearningServices/workspaces/outboundRules@2024-10-01"
  name                      = local.pe_rule_list[count.index].name
  parent_id                 = var.workspace_id
  schema_validation_enabled = false

  body = {
    type = "PrivateEndpoint"
    properties = {
      category = "UserDefined"
      status   = "Active"
      destination = {
        serviceResourceId = local.pe_rule_list[count.index].service_resource_id
        subresourceTarget = local.pe_rule_list[count.index].subresource_target
        sparkEnabled      = local.pe_rule_list[count.index].spark_enabled
      }
    }
  }
}
