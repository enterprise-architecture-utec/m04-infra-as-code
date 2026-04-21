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

resource "google_storage_bucket" "bucket_utec" {
  name          = var.bucket_name
  location      = "US"
  storage_class = "STANDARD"
  force_destroy = true

  # Acceso uniforme a nivel de bucket (desactiva ACLs por objeto)
  uniform_bucket_level_access = true

  # Versionado de objetos
  versioning {
    enabled = true
  }

  # Reglas de ciclo de vida
  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    }
    condition {
      age = 30 # dias
    }
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age                = 365
      with_state         = "ARCHIVED"
      num_newer_versions = 3
    }
  }

  # Registro de acceso (CORS para aplicaciones web)
  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }

  labels = {
    entorno = "laboratorio"
    curso   = "arquitectura-multinube"
    modulo  = "modulo-4-iac"
  }
}
