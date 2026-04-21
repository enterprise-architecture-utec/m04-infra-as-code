terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Dead Letter Topic (para mensajes fallidos)
resource "google_pubsub_topic" "dlq_topic" {
  name = "${var.topic_name}-dlq"

  message_retention_duration = "86400s" # 1 dia

  labels = {
    entorno = "laboratorio"
    tipo    = "dead-letter"
  }
}

# Topic principal
resource "google_pubsub_topic" "topic_utec" {
  name = var.topic_name

  message_retention_duration = "86400s" # 1 dia

  labels = {
    entorno = "laboratorio"
    curso   = "arquitectura-multinube"
    modulo  = "modulo-4-iac"
  }
}

# Suscripcion Pull (el consumidor pide los mensajes)
resource "google_pubsub_subscription" "sub_pull" {
  name  = "${var.topic_name}-pull"
  topic = google_pubsub_topic.topic_utec.name

  ack_deadline_seconds       = 30
  message_retention_duration = "3600s" # 1 hora
  retain_acked_messages      = false
  enable_message_ordering    = false

  expiration_policy {
    ttl = "86400s" # La suscripcion expira si no tiene actividad en 1 dia
  }

  retry_policy {
    minimum_backoff = "10s"
    maximum_backoff = "300s"
  }

  # Configurar Dead Letter
  dead_letter_policy {
    dead_letter_topic     = google_pubsub_topic.dlq_topic.id
    max_delivery_attempts = 5
  }

  labels = {
    tipo    = "pull"
    entorno = "laboratorio"
  }
}

# Suscripcion Push (GCP envia mensajes al endpoint)
# Nota: el endpoint debe ser HTTPS publico valido
resource "google_pubsub_subscription" "sub_push" {
  name  = "${var.topic_name}-push"
  topic = google_pubsub_topic.topic_utec.name

  ack_deadline_seconds       = 20
  message_retention_duration = "3600s"
  retain_acked_messages      = false

  # Para laboratorio usamos un endpoint ficticio
  # En produccion, reemplaza con tu URL real (HTTPS)
  push_config {
    push_endpoint = var.push_endpoint

    attributes = {
      x-goog-version = "v1"
    }
  }

  expiration_policy {
    ttl = "86400s"
  }

  labels = {
    tipo    = "push"
    entorno = "laboratorio"
  }
}

# Permiso para que Pub/Sub pueda publicar en el Dead Letter Topic
data "google_project" "project" {}

resource "google_pubsub_topic_iam_member" "dlq_publisher" {
  topic  = google_pubsub_topic.dlq_topic.name
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_pubsub_subscription_iam_member" "dlq_subscriber" {
  subscription = google_pubsub_subscription.sub_pull.name
  role         = "roles/pubsub.subscriber"
  member       = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}
