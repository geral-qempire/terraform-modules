resource "azapi_resource" "this" {
  type                      = "Microsoft.MachineLearningServices/workspaces/connections@2024-10-01"
  name                      = var.name
  parent_id                 = var.workspace_id
  schema_validation_enabled = false
  locks                     = var.locks

  body = {
    properties = {
      authType      = "AAD"
      category      = var.category
      target        = var.target
      metadata      = var.metadata
      isSharedToAll = var.is_shared_to_all
    }
  }
}
