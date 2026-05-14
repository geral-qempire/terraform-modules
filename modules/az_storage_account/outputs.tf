output "id" {
  description = "Resource ID of the storage account."
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "Name of the storage account."
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "Primary blob service endpoint URL."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "primary_file_endpoint" {
  description = "Primary file service endpoint URL."
  value       = azurerm_storage_account.this.primary_file_endpoint
}

output "primary_table_endpoint" {
  description = "Primary table service endpoint URL."
  value       = azurerm_storage_account.this.primary_table_endpoint
}

output "primary_queue_endpoint" {
  description = "Primary queue service endpoint URL."
  value       = azurerm_storage_account.this.primary_queue_endpoint
}

output "primary_dfs_endpoint" {
  description = "Primary DFS (Data Lake) service endpoint URL."
  value       = azurerm_storage_account.this.primary_dfs_endpoint
}

output "principal_id" {
  description = "Principal ID of the system-assigned managed identity."
  value       = azurerm_storage_account.this.identity[0].principal_id
}
