variable "project_name" {
  description = "Short project identifier used in resource names."
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, qa, staging, prod)."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "scope" {
  description = "Deployment scope: 'hub' or 'proj'."
  type        = string

  validation {
    condition     = contains(["hub", "proj"], var.scope)
    error_message = "Must be 'hub' or 'proj'."
  }
}

variable "ai_services_name_override" {
  description = "Optional name override for AI Services. If empty, auto-generated."
  type        = string
  default     = ""
}
