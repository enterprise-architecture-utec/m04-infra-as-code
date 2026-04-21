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

# Service Account para los nodos del cluster
resource "google_service_account" "gke_sa" {
  account_id   = "sa-utec-gke-lab06"
  display_name = "Service Account para GKE - UTEC Lab"
}

# Permisos minimos para los nodos GKE
resource "google_project_iam_member" "gke_sa_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_project_iam_member" "gke_sa_metric_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_project_iam_member" "gke_sa_artifact_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

# Cluster GKE
resource "google_container_cluster" "gke_utec" {
  name     = var.cluster_name
  location = "${var.region}-a"

  # Eliminar el node pool por defecto para usar uno personalizado
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.vpc_name
  subnetwork = var.subnet_name

  # Habilitar Workload Identity
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # Configuracion de red del cluster
  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {}

  # Modo de lanzamiento
  release_channel {
    channel = "REGULAR"
  }

  # Deshabilitar telemetria basica (para reducir costos en lab)
  logging_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }
}

# Node Pool personalizado
resource "google_container_node_pool" "np_utec" {
  name     = var.node_pool_name
  location = "${var.region}-a"
  cluster  = google_container_cluster.gke_utec.name

  node_count = var.node_count

  # Autoscaling del node pool
  autoscaling {
    min_node_count = 1
    max_node_count = 4
  }

  node_config {
    machine_type = var.machine_type
    disk_size_gb = 30
    disk_type    = "pd-standard"

    service_account = google_service_account.gke_sa.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      entorno = "laboratorio"
      curso   = "arquitectura-multinube"
    }

    tags = ["gke-node", "utec-lab"]

    shielded_instance_config {
      enable_secure_boot = true
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
