output "storage_account_id" {
  value       = azurerm_storage_account.this.id
  description = "The ID of the Storage Account."
}

output "storage_account_name" {
  value       = azurerm_storage_account.this.name
  description = "The Name of the Storage Account."
}

output "storage_account_primary_access_key" {
  value       = azurerm_storage_account.this.primary_access_key
  description = "Primary access key for the Storage Account."
  sensitive   = true
}

output "storage_account_primary_blob_endpoint" {
  value       = azurerm_storage_account.this.primary_blob_endpoint
  description = "Primary Blob service endpoint for the Storage Account."
}

output "storage_account_primary_file_endpoint" {
  value       = azurerm_storage_account.this.primary_file_endpoint
  description = "Primary File service endpoint for the Storage Account."
}

output "storage_account_primary_queue_endpoint" {
  value       = azurerm_storage_account.this.primary_queue_endpoint
  description = "Primary Queue service endpoint for the Storage Account."
}

output "storage_account_primary_table_endpoint" {
  value       = azurerm_storage_account.this.primary_table_endpoint
  description = "Primary Table service endpoint for the Storage Account."
}

