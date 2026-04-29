variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
}

variable "region" {
  description = "Region de GCP"
  type        = string
  default     = "us-central1"
}

variable "student_name" {
  description = "Nombre o iniciales del alumno (minúsculas)"
  type        = string
}

variable "student_id" {
  description = "ID único del alumno para segmentar la red"
  type        = number
}

variable "vpc_cidr_base" {
  description = "Base del bloque CIDR de la VPC"
  type        = string
  default     = "10"
}