variable "name" {
  description = "Name of the AI Hub workspace."
  type        = string
}

variable "location" {
  description = "Azure region for the AI Hub."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "storage_account_id" {
  description = "Resource ID of the default storage account."
  type        = string
}

variable "key_vault_id" {
  description = "Resource ID of the default key vault."
  type        = string
}

variable "application_insights_id" {
  description = "Resource ID of the Application Insights instance."
  type        = string
}

variable "container_registry_id" {
  description = "Resource ID of the container registry. Optional."
  type        = string
  default     = null
}

variable "public_network_access" {
  description = "Whether public network access is allowed. Possible values: Enabled, Disabled."
  type        = string
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Disabled"], var.public_network_access)
    error_message = "Must be one of: Enabled, Disabled."
  }
}

variable "managed_network_isolation_mode" {
  description = "Managed network isolation mode for the hub."
  type        = string
  default     = "Disabled"

  validation {
    condition     = contains(["Disabled", "AllowInternetOutbound", "AllowOnlyApprovedOutbound"], var.managed_network_isolation_mode)
    error_message = "Must be one of: Disabled, AllowInternetOutbound, AllowOnlyApprovedOutbound."
  }
}

variable "description" {
  description = "Description of the AI Hub workspace."
  type        = string
  default     = ""
}

variable "friendly_name" {
  description = "Friendly display name of the AI Hub."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to the AI Hub."
  type        = map(string)
  default     = {}
}
