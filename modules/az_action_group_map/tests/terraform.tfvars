name                = "ag-test-action-group"
resource_group_name = "rg-test"
enabled             = true

email_receivers = {
  primary = {
    email_address = "diogoazevedo15@gmail.com"
  }
}

tags = {
  Environment = "test"
  Project     = "terraform-modules"
}

infra_subscription_id = "2a4f4e29-3789-4e47-867d-62a6eb17950b"
