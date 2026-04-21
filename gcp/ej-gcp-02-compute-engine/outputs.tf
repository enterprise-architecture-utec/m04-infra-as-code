output "vm_name" {
  description = "Nombre de la instancia"
  value       = google_compute_instance.vm_utec.name
}

output "vm_public_ip" {
  description = "IP publica de la VM"
  value       = google_compute_instance.vm_utec.network_interface[0].access_config[0].nat_ip
}

output "vm_private_ip" {
  description = "IP privada de la VM"
  value       = google_compute_instance.vm_utec.network_interface[0].network_ip
}

output "vm_zone" {
  description = "Zona donde se despliega la VM"
  value       = google_compute_instance.vm_utec.zone
}

output "vm_instance_id" {
  description = "ID unico de la instancia"
  value       = google_compute_instance.vm_utec.instance_id
}
