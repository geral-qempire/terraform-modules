variable "workspace_id" {
  description = "Resource ID of the AI Hub workspace to add outbound rules to."
  type        = string
}

variable "fqdn_rules" {
  description = "List of FQDN destinations to allow through the managed network firewall."
  type        = list(string)
  default     = []
}

variable "private_endpoint_rules" {
  description = "Map of private endpoint outbound rules. Key is the rule name."
  type = map(object({
    service_resource_id = string
    subresource_target  = string
    spark_enabled       = optional(bool, false)
  }))
  default = {}
}
