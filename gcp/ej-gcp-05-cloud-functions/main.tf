terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Empaquetar el codigo fuente automaticamente
data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/function.zip"
}

# Bucket para almacenar el codigo
resource "google_storage_bucket" "function_bucket" {
  name                        = "${var.project_id}-fn-utec-lab05"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
}

# Subir el ZIP al bucket
resource "google_storage_bucket_object" "function_zip" {
  name   = "fn-utec-lab05-${data.archive_file.function_zip.output_md5}.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = data.archive_file.function_zip.output_path
}

# Cloud Function Gen 2
resource "google_cloudfunctions2_function" "fn_utec" {
  name     = var.function_name
  location = var.region

  build_config {
    runtime     = "python312"
    entry_point = "hello_http"

    source {
      storage_source {
        bucket = google_storage_bucket.function_bucket.name
        object = google_storage_bucket_object.function_zip.name
      }
    }
  }

  service_config {
    max_instance_count             = 10
    min_instance_count             = 0
    available_memory               = "256M"
    timeout_seconds                = 60
    ingress_settings               = "ALLOW_ALL"
    all_traffic_on_latest_revision = true

    environment_variables = {
      ENTORNO = "laboratorio"
      CURSO   = "Arquitectura Multinube"
    }
  }

  labels = {
    entorno = "laboratorio"
    curso   = "arquitectura-multinube"
  }
}

# Permitir invocaciones publicas (sin autenticacion)
resource "google_cloud_run_service_iam_member" "invoker" {
  project  = var.project_id
  location = var.region
  service  = google_cloudfunctions2_function.fn_utec.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
