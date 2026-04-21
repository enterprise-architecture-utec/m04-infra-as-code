terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

# Dead Letter Queue (DLQ) - recibe mensajes fallidos
resource "aws_sqs_queue" "dlq_utec" {
  name                      = "${var.queue_name}-dlq"
  message_retention_seconds = 86400 # 1 dia

  tags = {
    Name  = "${var.queue_name}-dlq"
    Curso = "Arquitectura Multinube"
  }
}

# Cola SQS principal
resource "aws_sqs_queue" "queue_utec" {
  name                       = var.queue_name
  delay_seconds              = 0
  max_message_size           = 262144 # 256 KB
  message_retention_seconds  = 86400  # 1 dia
  visibility_timeout_seconds = 30
  receive_wait_time_seconds  = 10 # Long polling

  # Configurar la DLQ
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq_utec.arn
    maxReceiveCount     = 3
  })

  tags = {
    Name   = var.queue_name
    Curso  = "Arquitectura Multinube"
    Modulo = "Modulo 4 - IaC"
  }
}

# SNS Topic
resource "aws_sns_topic" "topic_utec" {
  name = var.topic_name

  tags = {
    Name   = var.topic_name
    Curso  = "Arquitectura Multinube"
    Modulo = "Modulo 4 - IaC"
  }
}

# Politica SQS: permite que SNS publique en la cola
resource "aws_sqs_queue_policy" "sqs_policy" {
  queue_url = aws_sqs_queue.queue_utec.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "AllowSNSPublish"
      Effect    = "Allow"
      Principal = { Service = "sns.amazonaws.com" }
      Action    = "sqs:SendMessage"
      Resource  = aws_sqs_queue.queue_utec.arn
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.topic_utec.arn
        }
      }
    }]
  })
}

# Suscripcion SNS -> SQS
resource "aws_sns_topic_subscription" "sqs_subscription" {
  topic_arn            = aws_sns_topic.topic_utec.arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.queue_utec.arn
  raw_message_delivery = true
}
