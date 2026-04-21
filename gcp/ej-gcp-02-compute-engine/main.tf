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

# Regla de firewall: permite SSH desde cualquier IP
resource "google_compute_firewall" "fw_ssh" {
  name    = "fw-utec-allow-ssh"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-server"]
}

# Regla de firewall: permite HTTP
resource "google_compute_firewall" "fw_http" {
  name    = "fw-utec-allow-http"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}

# Instancia de Compute Engine
resource "google_compute_instance" "vm_utec" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = "${var.region}-a"

  tags = ["ssh-server", "web-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 20
      type  = "pd-standard"
    }
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = var.subnet_name

    # IP externa ephemeral
    access_config {}
  }

  # Script de inicio: instala y configura nginx
  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Hola desde UTEC - Compute Engine Lab02</h1><p>Instancia: $(hostname)</p>" \
      > /var/www/html/index.html
  EOF

  metadata = {
    curso  = "Arquitectura Multinube"
    modulo = "Modulo 4 - IaC"
  }

  labels = {
    entorno = "laboratorio"
    curso   = "arquitectura-multinube"
  }
}
