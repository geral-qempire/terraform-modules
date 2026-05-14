variable "name" {
  description = "Name of the private endpoint."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "subnet_id" {
  description = "Resource ID of the subnet to place the private endpoint in."
  type        = string
}

variable "private_connection_resource_id" {
  description = "Resource ID of the target resource for the private connection."
  type        = string
}

variable "subresource_names" {
  description = "List of sub-resource names (e.g. ['blob'], ['vault'], ['searchService'])."
  type        = list(string)
}

variable "private_dns_zone_ids" {
  description = "List of Private DNS Zone IDs to associate. If empty, no DNS zone group is created."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply."
  type        = map(string)
  default     = {}
}
