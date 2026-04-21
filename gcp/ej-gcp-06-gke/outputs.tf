output "cluster_name" {
  description = "Nombre del cluster GKE"
  value       = google_container_cluster.gke_utec.name
}

output "cluster_endpoint" {
  description = "Endpoint del cluster GKE"
  value       = google_container_cluster.gke_utec.endpoint
  sensitive   = true
}

output "node_pool_name" {
  description = "Nombre del Node Pool"
  value       = google_container_node_pool.np_utec.name
}

output "kubeconfig_command" {
  description = "Comando para obtener las credenciales del cluster"
  value       = "gcloud container clusters get-credentials ${google_container_cluster.gke_utec.name} --zone ${var.region}-a --project ${var.project_id}"
}

output "cluster_ca_certificate" {
  description = "Certificado CA del cluster"
  value       = google_container_cluster.gke_utec.master_auth[0].cluster_ca_certificate
  sensitive   = true
}
