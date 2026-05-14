variable "name" {
  description = "Name of the workspace connection."
  type        = string
}

variable "workspace_id" {
  description = "Resource ID of the parent AI Hub or Project workspace."
  type        = string
}

variable "category" {
  description = "Connection category."
  type        = string

  validation {
    condition = contains([
      "AzureBlob",
      "AzureOpenAI",
      "CognitiveSearch",
      "CognitiveService",
      "AzureSqlDb",
      "ApiKey",
      "CustomKeys",
    ], var.category)
    error_message = "Must be one of: AzureBlob, AzureOpenAI, CognitiveSearch, CognitiveService, AzureSqlDb, ApiKey, CustomKeys."
  }
}

variable "target" {
  description = "Target endpoint URL or resource ID for the connection."
  type        = string
}

variable "auth_type" {
  description = "Authentication type: AAD (Entra ID / RBAC) or ApiKey."
  type        = string
  default     = "AAD"

  validation {
    condition     = contains(["AAD", "ApiKey"], var.auth_type)
    error_message = "Must be AAD or ApiKey."
  }
}

variable "credentials_key" {
  description = "API key for ApiKey auth type. Required when auth_type = ApiKey."
  type        = string
  default     = null
  sensitive   = true
}

variable "metadata" {
  description = "Optional metadata key-value pairs for the connection."
  type        = map(string)
  default     = {}
}

variable "is_shared_to_all" {
  description = "Whether this connection is shared to all projects under the hub."
  type        = bool
  default     = true
}

variable "locks" {
  description = "List of resource IDs to lock during creation/update/deletion to serialise operations."
  type        = list(string)
  default     = []
}
