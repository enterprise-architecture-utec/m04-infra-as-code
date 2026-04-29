output "vpc_name" {
  value = google_compute_network.vpc_utec.name
}

output "subnet_id" {
  value = google_compute_subnetwork.subnet_utec.id
}

output "subnet_cidr" {
  value = google_compute_subnetwork.subnet_utec.ip_cidr_range
}