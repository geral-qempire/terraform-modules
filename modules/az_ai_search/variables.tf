variable "name" {
  description = "Name of the AI Search service."
  type        = string
}

variable "location" {
  description = "Azure region for the AI Search service."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "sku" {
  description = "SKU tier for the search service (free, basic, standard, standard2, standard3)."
  type        = string
  default     = "basic"

  validation {
    condition     = contains(["free", "basic", "standard", "standard2", "standard3"], var.sku)
    error_message = "Must be one of: free, basic, standard, standard2, standard3."
  }
}

variable "replica_count" {
  description = "Number of replicas. Higher count improves availability and read throughput."
  type        = number
  default     = 1
}

variable "partition_count" {
  description = "Number of partitions. Increases index storage capacity."
  type        = number
  default     = 1
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed."
  type        = bool
  default     = true
}

variable "local_authentication_enabled" {
  description = "Whether API key authentication is enabled. Set false to enforce RBAC-only."
  type        = bool
  default     = false
}

variable "authentication_failure_mode" {
  description = "Behaviour when authentication fails. Use null for default, or http403 to return 403."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the AI Search service."
  type        = map(string)
  default     = {}
}
