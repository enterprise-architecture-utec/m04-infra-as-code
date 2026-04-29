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

locals {
  function_name = var.function_name != null ? var.function_name : "fn-${var.student_name}-lab05"
  bucket_name   = "${var.project_id}-fn-${var.student_name}-lab05"
}

# Empaquetar el codigo fuente automaticamente
data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/function.zip"
}

# Bucket para almacenar el codigo
resource "google_storage_bucket" "function_bucket" {
  name                        = local.bucket_name
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
}

# Subir el ZIP al bucket
resource "google_storage_bucket_object" "function_zip" {
  name   = "fn-${var.student_name}-lab05-${data.archive_file.function_zip.output_md5}.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = data.archive_file.function_zip.output_path
}

# Cloud Function Gen 2
resource "google_cloudfunctions2_function" "fn_utec" {
  name     = local.function_name
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
      ENTORNO      = "laboratorio"
      CURSO        = "Arquitectura Multinube"
      STUDENT_NAME = var.student_name
      STUDENT_ID   = tostring(var.student_id)
    }
  }

  labels = {
    entorno      = "laboratorio"
    curso        = "arquitectura-multinube"
    student_name = var.student_name
    student_id   = tostring(var.student_id)
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
