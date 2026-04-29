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
  description = "ID único del alumno para segmentar recursos"
  type        = number
}

variable "function_name" {
  description = "Nombre de la Cloud Function"
  type        = string
  default     = null
}
