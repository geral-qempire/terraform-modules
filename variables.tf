variable "server_name" {
  description = "Name of the SQL server."
  type        = string
}

variable "database_name" {
  description = "Name of the SQL database."
  type        = string
}

variable "location" {
  description = "Azure region for the SQL server."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "sku_name" {
  description = "SKU name for the database (Basic, S0, S1, P1, etc.)."
  type        = string
  default     = "Basic"
}

variable "max_size_gb" {
  description = "Maximum size of the database in GB."
  type        = number
  default     = 2
}

variable "azuread_administrator" {
  description = "Azure AD administrator for the SQL server."
  type = object({
    login_username              = string
    object_id                   = string
    azuread_authentication_only = optional(bool, true)
  })
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "Minimum TLS version for the SQL server."
  type        = string
  default     = "1.2"
}

variable "tags" {
  description = "Tags to apply to SQL resources."
  type        = map(string)
  default     = {}
}
