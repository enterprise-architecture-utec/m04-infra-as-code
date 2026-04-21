output "vpc_name" {
  description = "Nombre de la VPC"
  value       = google_compute_network.vpc_utec.name
}

output "vpc_id" {
  description = "ID de la VPC"
  value       = google_compute_network.vpc_utec.id
}

output "subnet_id" {
  description = "ID de la Subnet"
  value       = google_compute_subnetwork.subnet_utec.id
}

output "subnet_self_link" {
  description = "Self-link de la Subnet"
  value       = google_compute_subnetwork.subnet_utec.self_link
}
