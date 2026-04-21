variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
  default     = "rg-utec-lab01"
}

variable "sql_server_name" {
  description = "Nombre unico del SQL Server (debe ser unico globalmente)"
  type        = string
  default     = "sql-utec-lab05"
}

variable "database_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "db-utec-laboratorio"
}

variable "sql_admin_login" {
  description = "Usuario administrador del SQL Server"
  type        = string
  default     = "sqladminUtec"
}

variable "sql_admin_password" {
  description = "Contrasena del administrador SQL (usar Key Vault en produccion)"
  type        = string
  default     = "P@ssw0rd1234!"
  sensitive   = true
}
