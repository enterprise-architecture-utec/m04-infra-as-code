variable "aws_region" {
  description = "Region de AWS"
  type        = string
  default     = "us-east-1"
}

variable "topic_name" {
  description = "Nombre del SNS Topic"
  type        = string
  default     = "topic-utec-lab08"
}

variable "queue_name" {
  description = "Nombre de la SQS Queue"
  type        = string
  default     = "queue-utec-lab08"
}
