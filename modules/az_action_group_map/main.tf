locals {
  action_group_short_name = substr(replace(var.name, "-", ""), 0, 12)
}

resource "azurerm_monitor_action_group" "this" {
  name                = var.name
  resource_group_name  = var.resource_group_name
  short_name           = local.action_group_short_name
  enabled              = var.enabled

  dynamic "email_receiver" {
    for_each = var.email_receivers
    content {
      name                    = email_receiver.key
      email_address           = email_receiver.value.email_address
      use_common_alert_schema = true
    }
  }

  tags = var.tags
}
