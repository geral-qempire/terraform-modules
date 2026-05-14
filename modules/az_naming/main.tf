locals {
  location_short_map = {
    "eastus"             = "eus"
    "eastus2"            = "eus2"
    "westus"             = "wus"
    "westus2"            = "wus2"
    "westus3"            = "wus3"
    "centralus"          = "cus"
    "southcentralus"     = "scus"
    "westeurope"         = "weu"
    "northeurope"        = "neu"
    "swedencentral"      = "swc"
    "uksouth"            = "uks"
    "ukwest"             = "ukw"
    "francecentral"      = "frc"
    "germanywestcentral" = "gwc"
    "italynorth"         = "itn"
    "japaneast"          = "jpe"
    "australiaeast"      = "aue"
    "canadacentral"      = "cac"
    "brazilsouth"        = "brs"
    "southafricanorth"   = "san"
    "uaenorth"           = "uan"
    "southindia"         = "si"
    "canadaeast"         = "cae"
    "spaincentral"       = "spc"
  }

  location_short = lookup(local.location_short_map, var.location, substr(var.location, 0, 4))
  name_suffix    = "${var.project_name}-${var.environment}-${local.location_short}"
  flat_suffix    = replace(local.name_suffix, "-", "")

  is_hub = var.scope == "hub"
  prefix = local.is_hub ? "hub" : "proj"

  resource_names = {
    resource_group   = local.is_hub ? "rg-${local.name_suffix}" : "rg-proj-${local.name_suffix}"
    workspace        = "mlw-${local.prefix}-${local.name_suffix}"
    storage          = "st${local.prefix}${local.flat_suffix}"
    storage_datalake = "stdl${local.prefix}${local.flat_suffix}"
    key_vault        = "kv${local.prefix}${local.flat_suffix}"
    ai_search        = "srch-${local.prefix}-${local.name_suffix}"
    sql_server       = "sql-${local.prefix}-${local.name_suffix}"
    sql_database     = "sqldb-${local.prefix}-${local.name_suffix}"
    app_insights     = "appi-${local.name_suffix}"
    log_analytics    = "log-${local.name_suffix}"
    ai_services      = var.ai_services_name_override != "" ? var.ai_services_name_override : "cog-${local.prefix}-${local.name_suffix}"
    vnet             = "vnet-${local.prefix}-${local.name_suffix}"
    subnet_pe        = "snet-pe-${local.prefix}-${local.name_suffix}"
  }
}
