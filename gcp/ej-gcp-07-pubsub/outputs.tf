output "topic_name" {
  description = "Nombre del Pub/Sub Topic"
  value       = google_pubsub_topic.topic_utec.name
}

output "topic_id" {
  description = "ID completo del Pub/Sub Topic"
  value       = google_pubsub_topic.topic_utec.id
}

output "pull_subscription_name" {
  description = "Nombre de la suscripcion Pull"
  value       = google_pubsub_subscription.sub_pull.name
}

output "push_subscription_name" {
  description = "Nombre de la suscripcion Push"
  value       = google_pubsub_subscription.sub_push.name
}

output "dead_letter_topic_name" {
  description = "Nombre del Dead Letter Topic"
  value       = google_pubsub_topic.dlq_topic.name
}
