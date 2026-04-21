variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
}

variable "region" {
  description = "Region de GCP"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "Nombre unico global del bucket (solo minusculas, numeros y guiones)"
  type        = string
  default     = "bucket-utec-laboratorio-2024"
}
