output "server_id" {
  description = "Resource ID of the SQL server."
  value       = azurerm_mssql_server.this.id
}

output "database_id" {
  description = "Resource ID of the SQL database."
  value       = azurerm_mssql_database.this.id
}

output "server_fqdn" {
  description = "Fully qualified domain name of the SQL server."
  value       = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "server_name" {
  description = "Name of the SQL server."
  value       = azurerm_mssql_server.this.name
}

output "server_principal_id" {
  description = "Principal ID of the SQL server system-assigned managed identity."
  value       = azurerm_mssql_server.this.identity[0].principal_id
}
