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

# VPC en modo personalizado con nombre único
resource "google_compute_network" "vpc_utec" {
  name                    = "vpc-utec-${var.student_name}"
  auto_create_subnetworks = false
  description             = "VPC para laboratorios UTEC - Alumno: ${var.student_name}"
}

# Subnet regional con CIDR dinámico: 10.[student_id].1.0/24
resource "google_compute_subnetwork" "subnet_utec" {
  name          = "subnet-utec-${var.student_name}"
  ip_cidr_range = "${var.vpc_cidr_base}.${var.student_id}.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_utec.id

  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}