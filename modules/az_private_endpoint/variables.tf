variable "name" {
  type        = string
  description = "Name of the private endpoint."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the private endpoint exists."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the private endpoint should exist."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where private endpoint will be deployed."
  default     = null
  validation {
    condition = var.subnet_id != null || (var.subnet_name != null && var.virtual_network_name != null)
    error_message = "Provide subnet_id or both subnet_name and virtual_network_name."
  }
}

variable "subnet_name" {
  type        = string
  default     = null
  description = "Subnet name used when subnet_id is not provided."
}

variable "virtual_network_name" {
  type        = string
  default     = null
  description = "Virtual network name for subnet lookup when subnet_id is not provided."
}

variable "virtual_network_resource_group_name" {
  type        = string
  default     = null
  description = "Resource group containing the virtual network (defaults to resource_group_name when unset)."
}

variable "private_connection_resource_id" {
  type        = string
  description = "The ID of the resource to which the private endpoint will connect."
}

variable "private_dns_zones" {
  type        = list(string)
  description = "List of private DNS zone names to associate with the private endpoint."
  default     = []
}

variable "dns_resource_group_name" {
  type        = string
  description = "Resource Group name containing the Private DNS Zones."
  default     = ""
}

variable "subresource_names" {
  type        = list(string)
  description = "List of subresource names for the private endpoint (e.g., ['blob'], ['file'], ['blob', 'queue'])."
}

variable "is_manual_connection" {
  type        = bool
  description = "Whether the connection is manual (requires approval) or automatic."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Optional tags to add to resources."
  default     = {}
}

variable "private_endpoint_location" {
  type        = string
  description = "Location to deploy Private Endpoint. If empty, falls back to module location."
  default     = ""
}

