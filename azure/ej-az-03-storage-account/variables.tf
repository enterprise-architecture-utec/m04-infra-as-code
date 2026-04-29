variable "resource_group_name" {
  description = "Nombre del Resource Group asignado al alumno"
  type        = string
}

variable "student_name" {
  description = "Nombre o iniciales del alumno (solo minúsculas y números)"
  type        = string
}

variable "student_id" {
  description = "ID único del alumno (ej: 01, 02...)"
  type        = string
}

variable "container_name" {
  description = "Nombre del contenedor Blob"
  type        = string
  default     = "archivos-utec"
}