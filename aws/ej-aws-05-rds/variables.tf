variable "aws_region" {
  description = "Region de AWS"
  type        = string
  default     = "us-east-1"
}

variable "db_identifier" {
  description = "Identificador de la instancia RDS"
  type        = string
  default     = "rds-utec-lab05"
}

variable "db_name" {
  description = "Nombre de la base de datos inicial"
  type        = string
  default     = "utecdb"
}

variable "db_username" {
  description = "Usuario administrador de la BD"
  type        = string
  default     = "adminutec"
}

variable "db_password" {
  description = "Contrasena del administrador (usar Secrets Manager en produccion)"
  type        = string
  default     = "P@ssw0rd1234!"
  sensitive   = true
}

variable "db_instance_class" {
  description = "Tipo de instancia RDS"
  type        = string
  default     = "db.t3.micro"
}
