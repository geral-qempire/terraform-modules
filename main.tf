resource "azapi_resource" "this" {
  type                      = "Microsoft.MachineLearningServices/workspaces@2024-10-01"
  name                      = var.name
  location                  = var.location
  parent_id                 = var.resource_group_id
  schema_validation_enabled = false

  body = {
    kind = "Project"
    identity = {
      type = "SystemAssigned"
    }
    properties = {
      friendlyName = var.friendly_name != "" ? var.friendly_name : var.name
      description  = var.description
      hubResourceId = var.hub_workspace_id
    }
  }

  tags = var.tags
}
