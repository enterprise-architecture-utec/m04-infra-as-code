variable "student_name" {
  description = "Nombre o iniciales del alumno (ej: jose)"
  type        = string
}

variable "student_id" {
  description = "Número correlativo del alumno (ej: 1, 2, 3) para segmentar la red"
  type        = number
}

variable "resource_group_name" {
  description = "Nombre del Resource Group asignado al alumno"
  type        = string
}

variable "vnet_cidr_base" {
  description = "Base del bloque CIDR de la VNet"
  type        = string
  default     = "10"
}