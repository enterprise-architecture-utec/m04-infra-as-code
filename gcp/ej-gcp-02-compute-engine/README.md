# EJ-GCP-02: Crear una VM en Compute Engine

## 🎯 Objetivo
Lanzar una instancia de Compute Engine con Debian 12 en la VPC creada anteriormente, con regla de firewall para SSH y HTTP.

## 📋 Conceptos Clave
- **Compute Engine:** Servicio de VMs de GCP, equivalente a EC2 en AWS o VM en Azure.
- **`e2-micro`:** Tipo de máquina económico (0.25 vCPU, 1 GB RAM) — parte del Free Tier.
- **Firewall Rule:** En GCP el firewall es a nivel de VPC y se aplica por etiquetas de red (`network tags`).
- **`access_config {}`:** Bloque vacío que asigna una IP externa ephemeral a la VM.
- **`metadata_startup_script`:** Script que se ejecuta al iniciar la VM por primera vez.

## 📁 Archivos
```
ej-gcp-02-compute-engine/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Pre-requisito
Asegúrate de tener la VPC del ejercicio GCP-01.

### Paso 2: Aplicar
```bash
terraform init
terraform plan -var="project_id=<TU_PROJECT_ID>"
terraform apply -var="project_id=<TU_PROJECT_ID>" -auto-approve
```

### Paso 3: Conectarse por SSH
```bash
# Opción A: gcloud SSH (recomendada — no requiere clave SSH manual)
gcloud compute ssh vm-utec-lab02 --zone=us-central1-a

# Opción B: SSH directo (necesitas par de claves)
VM_IP=$(terraform output -raw vm_public_ip)
ssh -i ~/.ssh/id_rsa <tu_usuario>@$VM_IP
```

### Paso 4: Verificar el servidor web
```bash
VM_IP=$(terraform output -raw vm_public_ip)
curl http://$VM_IP
# Debería responder: "Hola desde UTEC - Compute Engine Lab02"
```

### Paso 5: Destruir
```bash
terraform destroy -var="project_id=<TU_PROJECT_ID>" -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:
vm_instance_id = "1234567890123456789"
vm_name        = "vm-utec-lab02"
vm_public_ip   = "34.X.X.X"
vm_zone        = "us-central1-a"
```

## 📝 Notas
- `e2-micro` es parte del Free Tier de GCP: 1 instancia gratuita por mes en us-central1, us-west1 o us-east1.
- Las `network_tags` conectan la VM con las Firewall Rules — solo VMs con la etiqueta `web-server` reciben el tráfico.
- `metadata_startup_script` es el equivalente de `user_data` en AWS.
