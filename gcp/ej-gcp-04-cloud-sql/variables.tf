variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
}

variable "region" {
  description = "Region de GCP"
  type        = string
  default     = "us-central1"
}

variable "instance_name" {
  description = "Nombre de la instancia Cloud SQL"
  type        = string
  default     = "sql-utec-lab04"
}

variable "tier" {
  description = "Tipo de maquina para Cloud SQL"
  type        = string
  default     = "db-f1-micro"
}

variable "database_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "utecdb"
}

variable "db_username" {
  description = "Usuario de la base de datos"
  type        = string
  default     = "adminutec"
}

variable "db_password" {
  description = "Password del usuario (usar Secret Manager en produccion)"
  type        = string
  default     = "P@ssw0rd1234!"
  sensitive   = true
}
