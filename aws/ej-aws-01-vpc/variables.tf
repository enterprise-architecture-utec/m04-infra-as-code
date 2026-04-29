variable "aws_region" {
  description = "Region de AWS"
  type        = string
  default     = "us-east-1"
}

variable "student_name" {
  description = "Nombre o iniciales del alumno para evitar duplicados"
  type        = string
}

variable "student_id" {
  description = "Número correlativo del alumno (ej: 1, 2, 3) para segmentar la red"
  type        = number
#  default     = 1
}

variable "vpc_cidr_base" {
  description = "Base del bloque CIDR de la VPC"
  type        = string
  default     = "10"
}