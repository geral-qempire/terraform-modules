module "action_group" {
  source = "../"

  name                = var.name
  resource_group_name = var.resource_group_name
  enabled             = var.enabled
  email_receivers     = var.email_receivers
  tags                = var.tags
}
