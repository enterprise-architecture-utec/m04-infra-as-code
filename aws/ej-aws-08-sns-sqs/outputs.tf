output "sns_topic_arn" {
  description = "ARN del SNS Topic"
  value       = aws_sns_topic.topic_utec.arn
}

output "sns_topic_name" {
  description = "Nombre del SNS Topic"
  value       = aws_sns_topic.topic_utec.name
}

output "sqs_queue_url" {
  description = "URL de la SQS Queue principal"
  value       = aws_sqs_queue.queue_utec.id
}

output "sqs_queue_arn" {
  description = "ARN de la SQS Queue principal"
  value       = aws_sqs_queue.queue_utec.arn
}

output "sqs_dlq_url" {
  description = "URL de la Dead Letter Queue"
  value       = aws_sqs_queue.dlq_utec.id
}
