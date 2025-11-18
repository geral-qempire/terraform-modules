variable "rbac" {
  description = "Map of RBAC bindings keyed by a stable id"
  type = map(object({
    principal_id         = string
    scope                = optional(string)
    role_definition_id   = optional(string)
    role_definition_name = optional(string)
    principal_type       = optional(string)
  }))
}

variable "skip_service_principal_aad_check" {
  type    = bool
  default = true
}
