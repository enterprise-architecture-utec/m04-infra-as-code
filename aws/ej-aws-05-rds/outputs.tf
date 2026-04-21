output "rds_endpoint" {
  description = "Endpoint de conexion a la base de datos"
  value       = aws_db_instance.rds_utec.endpoint
}

output "rds_port" {
  description = "Puerto de la base de datos"
  value       = aws_db_instance.rds_utec.port
}

output "db_name" {
  description = "Nombre de la base de datos"
  value       = aws_db_instance.rds_utec.db_name
}

output "rds_username" {
  description = "Usuario de la base de datos"
  value       = aws_db_instance.rds_utec.username
}
