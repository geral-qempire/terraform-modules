variable "name" {
  description = "Name of the AI Project workspace."
  type        = string
}

variable "location" {
  description = "Azure region for the AI Project."
  type        = string
}

variable "resource_group_id" {
  description = "Resource ID of the resource group where the project is deployed (can differ from hub RG)."
  type        = string
}

variable "hub_workspace_id" {
  description = "Resource ID of the parent AI Hub workspace."
  type        = string
}

variable "description" {
  description = "Description of the AI Project."
  type        = string
  default     = ""
}

variable "friendly_name" {
  description = "Friendly display name of the AI Project."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to the AI Project."
  type        = map(string)
  default     = {}
}
