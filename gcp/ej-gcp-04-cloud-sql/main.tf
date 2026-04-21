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

# Instancia Cloud SQL con PostgreSQL
resource "google_sql_database_instance" "sql_utec" {
  name             = var.instance_name
  database_version = "POSTGRES_15"
  region           = var.region

  deletion_protection = false

  settings {
    tier              = var.tier
    availability_type = "ZONAL"
    disk_size         = 10
    disk_type         = "PD_SSD"

    backup_configuration {
      enabled    = true
      start_time = "03:00"
    }

    ip_configuration {
      ipv4_enabled = true

      # Permitir acceso desde cualquier IP (solo para laboratorio)
      authorized_networks {
        name  = "acceso-laboratorio"
        value = "0.0.0.0/0"
      }
    }

    database_flags {
      name  = "log_connections"
      value = "on"
    }

    insights_config {
      query_insights_enabled  = true
      query_string_length     = 1024
      record_application_tags = false
      record_client_address   = false
    }
  }
}

# Base de datos PostgreSQL
resource "google_sql_database" "db_utec" {
  name     = var.database_name
  instance = google_sql_database_instance.sql_utec.name
  charset  = "UTF8"
}

# Usuario de la base de datos
resource "google_sql_user" "user_utec" {
  name     = var.db_username
  instance = google_sql_database_instance.sql_utec.name
  password = var.db_password
}
