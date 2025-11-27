variable "name" {
  type        = string
  description = "Name of the storage account."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the Storage Account should exist."
}

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "The Tier to use for this storage account. Possible values are Standard and Premium."
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
  description = "The type of replication to use for this storage account. Possible values include LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = "Defines the Kind of account. Possible values are Storage, StorageV2 and BlobStorage."
}

variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Possible values are Hot and Cool."
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "The minimum supported TLS version for the storage account."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether Public Network Access is allowed for this resource."
}

variable "shared_access_key_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether the storage account permits Shared Key access."
}

variable "infrastructure_encryption_enabled" {
  type        = bool
  default     = false
  description = "Enables infrastructure encryption."
}

variable "enable_geo_priority_replication" {
  type        = bool
  default     = false
  description = "Enables Geo Priority Replication for blob storage via AzAPI."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to add to resources."
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = {
    type = "SystemAssigned"
  }
  description = "Managed identity configuration. Possible types: SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned."
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "Possible values are SystemAssigned, UserAssigned, and SystemAssigned, UserAssigned."
  }
}

variable "network_rules_bypass" {
  type        = list(string)
  default     = ["AzureServices"]
  description = "List of services which bypass the network rules. Common values include AzureServices, Logging, Metrics, None."
  validation {
    condition = length([
      for v in var.network_rules_bypass : v if contains(["AzureServices", "Logging", "Metrics"], v)
    ]) == length(var.network_rules_bypass)
    error_message = "Allowed values for network_rules_bypass are AzureServices, Logging, Metrics. Use an empty list for no bypass."
  }
}

variable "network_rules_default_action" {
  type        = string
  default     = "Deny"
  description = "The default action for network rules. Possible values are Allow or Deny."
}

variable "network_rules_ip_rules" {
  type        = list(string)
  default     = []
  description = "List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed."
}

#####################################################################
# Blob service configuration
#####################################################################

variable "blob_versioning_enabled" {
  type        = bool
  default     = false
  description = "Enable blob versioning on the storage account."
}

variable "blob_last_access_time_enabled" {
  type        = bool
  default     = false
  description = "Enable last access time tracking for blob service."
}

variable "blob_delete_retention_days" {
  type        = number
  default     = 7
  description = "Retention (in days) for blob soft delete. Defaults to 7 (bronze tier). Set to null to disable."
  nullable    = true
}

variable "container_delete_retention_days" {
  type        = number
  default     = 7
  description = "Retention (in days) for container soft delete. Defaults to 7 (bronze tier). Set to null to disable."
  nullable    = true
}

#####################################################################
# Lifecycle Management Policy
#####################################################################

variable "lifecycle_management_policy_rules" {
  type = list(object({
    name = string
    filters = object({
      blob_types   = optional(list(string), ["blockBlob"])
      prefix_match = optional(list(string), [])
    })
    actions = object({
      version = optional(object({
        change_tier_to_cool_after_days_since_creation = optional(number)
        delete_after_days_since_creation              = optional(number)
      }))
      base_blob = optional(object({
        auto_tier_to_hot_from_cool_enabled                             = optional(bool)
        tier_to_cool_after_days_since_last_access_time_greater_than    = optional(number)
        tier_to_cold_after_days_since_last_access_time_greater_than    = optional(number)
        tier_to_archive_after_days_since_last_access_time_greater_than = optional(number)
        delete_after_days_since_last_access_time_greater_than          = optional(number)
      }))
    })
  }))
  default     = []
  description = "List of lifecycle management policy rules. Each rule can have version actions and/or base_blob actions. Empty list means no lifecycle policy will be created (bronze tier default)."
}

