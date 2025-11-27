variable "resource_type" {
  type        = string
  description = "The resource type abbreviation (e.g., rg, st, vnet)"
}

variable "location" {
  type        = string
  description = "The full location name (e.g., North Europe, northeurope). Will be mapped to abbreviation."
}

variable "project_name" {
  type        = string
  description = "The project name (e.g., cipo)"
}

variable "environment" {
  type        = string
  description = "The environment (e.g., dev, qua, prd)"
}

variable "random_postfix" {
  type        = bool
  default     = false
  description = "Whether to append a random 4-character postfix to the name"
}

variable "org_code" {
  type        = string
  default     = null
  description = "Optional organization code to include in the name (e.g., bdso)"
}

variable "merged" {
  type        = bool
  default     = false
  description = "Whether to merge all parts together without separators (no hyphens)"
}


