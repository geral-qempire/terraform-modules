variable "name" {
  description = "Base name of the storage account. A 4-char random suffix is appended automatically. Lowercase alphanumeric only, max 20 chars."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,20}$", var.name))
    error_message = "Storage account base name must be 3-20 characters (4-char suffix is appended), lowercase letters and numbers only."
  }
}

variable "location" {
  description = "Azure region for the storage account."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "account_tier" {
  description = "Performance tier of the storage account."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Must be Standard or Premium."
  }
}

variable "account_replication_type" {
  description = "Replication type (LRS, ZRS, GRS, GZRS, RA-GRS, RA-GZRS)."
  type        = string
  default     = "LRS"
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed."
  type        = bool
  default     = true
}

variable "allow_nested_items_to_be_public" {
  description = "Whether nested items (blobs, containers) can be set to public access."
  type        = bool
  default     = false
}

variable "is_hns_enabled" {
  description = "Enable hierarchical namespace (Data Lake Storage Gen2)."
  type        = bool
  default     = false
}

variable "network_bypass" {
  description = "Services that bypass network rules."
  type        = list(string)
  default     = ["AzureServices"]
}

variable "network_default_action" {
  description = "Default action for network rules when no rule matches."
  type        = string
  default     = "Deny"
}

variable "network_ip_rules" {
  description = "List of IP addresses or CIDR ranges to allow."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to the storage account."
  type        = map(string)
  default     = {}
}
