variable "name" {
  description = "FQDN of the Private DNS Zone (e.g. privatelink.blob.core.windows.net)."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "vnet_id" {
  description = "Resource ID of the VNet to link to the DNS zone."
  type        = string
}

variable "tags" {
  description = "Tags to apply."
  type        = map(string)
  default     = {}
}
