variable "name" {
  description = "Base name of the key vault. A 4-char random suffix is appended automatically. Max 20 chars."
  type        = string
}

variable "location" {
  description = "Azure region for the key vault."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID for the key vault."
  type        = string
}

variable "sku_name" {
  description = "SKU name for the key vault (standard or premium)."
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "Must be standard or premium."
  }
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed."
  type        = bool
  default     = true
}

variable "purge_protection_enabled" {
  description = "Enable purge protection to prevent permanent deletion during retention period."
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain soft-deleted items."
  type        = number
  default     = 90
}

variable "network_bypass" {
  description = "Services that bypass network rules."
  type        = string
  default     = "AzureServices"
}

variable "network_default_action" {
  description = "Default action when no network rule matches."
  type        = string
  default     = "Deny"
}

variable "network_ip_rules" {
  description = "List of IP addresses or CIDR ranges to allow."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to the key vault."
  type        = map(string)
  default     = {}
}
