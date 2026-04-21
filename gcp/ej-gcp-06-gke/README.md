# EJ-GCP-06: Crear un Cluster GKE (Kubernetes Engine)

## 🎯 Objetivo
Crear un clúster de Kubernetes administrado (GKE) con un node pool personalizado usando Terraform, y desplegar un pod de prueba.

## 📋 Conceptos Clave
- **GKE (Google Kubernetes Engine):** Servicio de Kubernetes administrado de GCP.
- **Node Pool:** Grupo de nodos (VMs) con la misma configuración dentro de un clúster GKE.
- **`remove_default_node_pool = true`:** Elimina el node pool inicial para usar uno personalizado.
- **Workload Identity:** Permite que los pods accedan a servicios GCP usando cuentas de servicio de K8s.
- **`e2-medium`:** 2 vCPU, 4 GB RAM — mínimo recomendable para GKE.

## 📁 Archivos
```
ej-gcp-06-gke/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Habilitar las APIs
```bash
gcloud services enable container.googleapis.com
gcloud services enable compute.googleapis.com
```

### Paso 2: Aplicar
```bash
terraform init
terraform plan -var="project_id=<TU_PROJECT_ID>"
terraform apply -var="project_id=<TU_PROJECT_ID>" -auto-approve
# ⏱️ GKE tarda entre 8-15 minutos en estar disponible
```

### Paso 3: Obtener credenciales del clúster
```bash
gcloud container clusters get-credentials gke-utec-lab06 \
  --zone us-central1-a \
  --project <TU_PROJECT_ID>
```

### Paso 4: Verificar el clúster
```bash
kubectl get nodes
kubectl get namespaces
kubectl cluster-info
```

### Paso 5: Desplegar una aplicación de prueba
```bash
# Crear un deployment de nginx
kubectl create deployment nginx --image=nginx:latest --replicas=2

# Exponer como servicio LoadBalancer
kubectl expose deployment nginx --port=80 --type=LoadBalancer

# Ver el estado (esperar la IP externa)
kubectl get services -w

# Verificar pods
kubectl get pods
```

### Paso 6: Destruir
```bash
# Eliminar los recursos de K8s primero (para liberar Load Balancers)
kubectl delete service nginx
kubectl delete deployment nginx

# Luego destruir con Terraform
terraform destroy -var="project_id=<TU_PROJECT_ID>" -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:
cluster_endpoint    = <sensitive>
cluster_name        = "gke-utec-lab06"
node_pool_name      = "np-utec-standard"
kubeconfig_command  = "gcloud container clusters get-credentials gke-utec-lab06 --zone us-central1-a --project mi-proyecto"
```

## 📝 Notas
- GKE cobra por los nodos (VMs) — 2 nodos `e2-medium` generan costos. Destruye al terminar el lab.
- `e2-medium` (2 vCPU, 4 GB) es el mínimo recomendable para clústeres funcionales.
- En producción usa clústeres regionales (multi-zona) para alta disponibilidad.
