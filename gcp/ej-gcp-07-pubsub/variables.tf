variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
}

variable "region" {
  description = "Region de GCP"
  type        = string
  default     = "us-central1"
}

variable "topic_name" {
  description = "Nombre del Pub/Sub Topic"
  type        = string
  default     = "topic-utec-lab07"
}

variable "push_endpoint" {
  description = "URL HTTPS del endpoint para la suscripcion push (debe ser publico y valido)"
  type        = string
  default     = "https://httpbin.org/post"
}
