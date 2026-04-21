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

# VPC en modo personalizado (sin subnets automaticas)
resource "google_compute_network" "vpc_utec" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  description             = "VPC para laboratorios UTEC - Arquitectura Multinube"
}

# Subnet regional
resource "google_compute_subnetwork" "subnet_utec" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_utec.id

  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
