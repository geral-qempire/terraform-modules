# Generate random postfix if requested
resource "random_string" "postfix" {
  count   = var.random_postfix ? 1 : 0
  length  = 4
  special = false
  upper   = false
  numeric = true
}


