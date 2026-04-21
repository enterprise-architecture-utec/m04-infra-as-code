variable "aws_region" {
  description = "Region de AWS"
  type        = string
  default     = "us-east-1"
}

variable "function_name" {
  description = "Nombre de la funcion Lambda"
  type        = string
  default     = "fn-utec-lab04"
}
