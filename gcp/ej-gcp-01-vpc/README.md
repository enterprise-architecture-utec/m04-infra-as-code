# EJ-GCP-01: Configurar el Provider y Crear una VPC en GCP

## 🎯 Objetivo
Configurar el provider de Google Cloud en Terraform y crear una red VPC personalizada con una subred regional. En GCP las VPCs son globales pero las subnets son regionales.

## 📋 Conceptos Clave
- **VPC en GCP:** Red global — una sola VPC puede tener subnets en múltiples regiones.
- **`auto_create_subnetworks = false`:** Modo personalizado — define manualmente las subnets.
- **Subnet regional:** Cada subnet existe en una región específica (ej: `us-central1`).
- **Application Default Credentials:** Mecanismo de autenticación recomendado para GCP + Terraform.

## 📁 Archivos
```
ej-gcp-01-vpc/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Autenticarse en GCP
```bash
gcloud auth application-default login
gcloud config set project <TU_PROJECT_ID>
```

### Paso 2: Habilitar la API de Compute Engine
```bash
gcloud services enable compute.googleapis.com
```

### Paso 3: Aplicar
```bash
terraform init

terraform plan \
  -var="project_id=<TU_PROJECT_ID>" \
  -var="student_name=XXX" \
  -var="student_id=X"

terraform apply \
  -var="project_id=<TU_PROJECT_ID>" \
  -var="student_name=XXX" \
  -var="student_id=X" \
  -auto-approve
```

### Paso 4: Verificar en la consola GCP
1. Ir a **VPC Network** → **VPC Networks**
2. Tu red aparecerá como vpc-utec-tu_nombre.
3. Valida que tu subnet tenga el rango IP `10.[tu_id].1.0/24`.


### Paso 5: Destruir
```bash
terraform destroy \
  -var="project_id=<TU_PROJECT_ID>" \
  -var="student_name=XXX" \
  -var="student_id=X" \
  -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:
subnet_id        = "projects/mi-proyecto/regions/us-central1/subnetworks/subnet-utec-lab01"
subnet_self_link = "https://www.googleapis.com/compute/v1/projects/.../subnet-utec-lab01"
vpc_id           = "projects/mi-proyecto/global/networks/vpc-utec-lab01"
vpc_name         = "vpc-utec-lab01"
```

## 📝 Notas
- En GCP puedes usar un archivo `terraform.tfvars` con `project_id = "mi-proyecto"` para evitar pasar la variable cada vez.
- Las VPCs en GCP son globales — una misma VPC puede tener subnets en distintos continentes.
- `private_ip_google_access = true` permite que las VMs sin IP pública accedan a APIs de Google.
