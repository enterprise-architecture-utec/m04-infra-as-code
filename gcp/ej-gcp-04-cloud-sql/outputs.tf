output "sql_instance_name" {
  description = "Nombre de la instancia Cloud SQL"
  value       = google_sql_database_instance.sql_utec.name
}

output "sql_connection_name" {
  description = "Connection name para Cloud SQL Auth Proxy"
  value       = google_sql_database_instance.sql_utec.connection_name
}

output "sql_public_ip" {
  description = "IP publica de la instancia Cloud SQL"
  value       = google_sql_database_instance.sql_utec.public_ip_address
}

output "database_name" {
  description = "Nombre de la base de datos"
  value       = google_sql_database.db_utec.name
}
