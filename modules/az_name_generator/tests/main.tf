module "name_generator" {
  source = "../"

  resource_type  = var.resource_type
  location       = var.location
  project_name   = var.project_name
  environment    = var.environment
  org_code       = var.org_code
  random_postfix = var.random_postfix
  merged         = var.merged
}
