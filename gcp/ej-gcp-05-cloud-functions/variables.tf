variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
}

variable "region" {
  description = "Region de GCP"
  type        = string
  default     = "us-central1"
}

variable "function_name" {
  description = "Nombre de la Cloud Function"
  type        = string
  default     = "fn-utec-lab05"
}
