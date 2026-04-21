variable "aws_region" {
  description = "Region de AWS"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Nombre unico global del bucket S3 (solo minusculas, numeros y guiones)"
  type        = string
  default     = "utec-laboratorio-multinube-2024"
}
