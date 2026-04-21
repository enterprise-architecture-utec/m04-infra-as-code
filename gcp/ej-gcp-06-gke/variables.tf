variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
}

variable "region" {
  description = "Region de GCP"
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "Nombre de la VPC (del ejercicio GCP-01)"
  type        = string
  default     = "vpc-utec-lab01"
}

variable "subnet_name" {
  description = "Nombre de la subnet (del ejercicio GCP-01)"
  type        = string
  default     = "subnet-utec-lab01"
}

variable "cluster_name" {
  description = "Nombre del cluster GKE"
  type        = string
  default     = "gke-utec-lab06"
}

variable "node_pool_name" {
  description = "Nombre del node pool"
  type        = string
  default     = "np-utec-standard"
}

variable "node_count" {
  description = "Numero de nodos en el node pool"
  type        = number
  default     = 2
}

variable "machine_type" {
  description = "Tipo de maquina para los nodos"
  type        = string
  default     = "e2-medium"
}
