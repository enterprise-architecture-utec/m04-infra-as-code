output "sql_server_name" {
  description = "Nombre del SQL Server"
  value       = azurerm_mssql_server.sql_server.name
}

output "sql_server_fqdn" {
  description = "FQDN del SQL Server para conexion"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "database_name" {
  description = "Nombre de la base de datos creada"
  value       = azurerm_mssql_database.db_utec.name
}
