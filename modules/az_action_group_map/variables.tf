variable "name" {
  type        = string
  description = "Name of the action group."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group in which to create the action group."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether the action group is enabled."
}

variable "email_receivers" {
  description = "Map of email receivers to add to the action group, keyed by receiver name."
  type = map(object({
    email_address = string
  }))
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags applied to the action group."
}
