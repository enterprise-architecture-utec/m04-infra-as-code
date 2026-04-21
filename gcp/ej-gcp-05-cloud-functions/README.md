# EJ-GCP-05: Crear una Cloud Function (2ª Generación)

## 🎯 Objetivo
Desplegar una Cloud Function de 2ª generación en Python que responda a solicitudes HTTP. Las Cloud Functions son el servicio serverless de GCP para ejecutar código sin gestionar servidores.

## 📋 Conceptos Clave
- **Cloud Functions Gen 2:** Basada en Cloud Run — mayor control, más opciones de configuración.
- **Cloud Storage como fuente:** El código se sube como ZIP a un bucket antes de desplegarse.
- **`archive_file`:** Data source de Terraform que empaqueta automáticamente el código en ZIP.
- **Cloud Run Service:** Gen 2 crea un servicio Cloud Run internamente.
- **IAM binding:** Permite invocaciones públicas (`allUsers`) sin autenticación.

## 📁 Archivos
```
ej-gcp-05-cloud-functions/
├── main.tf
├── variables.tf
├── outputs.tf
├── src/
│   ├── main.py          ← Código de la función
│   └── requirements.txt ← Dependencias Python
└── README.md
```

## 🚀 Pasos

### Paso 1: Habilitar las APIs necesarias
```bash
gcloud services enable cloudfunctions.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable artifactregistry.googleapis.com
```

### Paso 2: Aplicar
```bash
terraform init
terraform plan -var="project_id=<TU_PROJECT_ID>"
terraform apply -var="project_id=<TU_PROJECT_ID>" -auto-approve
# ⏱️ El build puede tardar 3-5 minutos
```

### Paso 3: Invocar la función
```bash
FUNCTION_URL=$(terraform output -raw function_url)

# GET sin parámetros
curl $FUNCTION_URL

# GET con parámetro nombre
curl "$FUNCTION_URL?nombre=UTEC"

# POST con JSON body
curl -X POST $FUNCTION_URL \
  -H "Content-Type: application/json" \
  -d '{"nombre": "Estudiante", "mensaje": "Hola desde GCP!"}'
```

### Paso 4: Ver logs
```bash
gcloud functions logs read fn-utec-lab05 --gen2 --region=us-central1 --limit=50
```

### Paso 5: Destruir
```bash
terraform destroy -var="project_id=<TU_PROJECT_ID>" -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:
function_name    = "fn-utec-lab05"
function_url     = "https://fn-utec-lab05-abc123-uc.a.run.app"
function_region  = "us-central1"
```

Respuesta del curl:
```json
{
  "mensaje": "Hola UTEC desde Cloud Functions Gen 2!",
  "entorno": "laboratorio",
  "metodo": "GET"
}
```

## 📝 Notas
- Cloud Functions Gen 2 tiene 2 millones de invocaciones gratuitas por mes.
- `min_instance_count = 0` significa que se apaga completamente cuando no hay tráfico (cold start).
- Para producción, usa `min_instance_count = 1` para eliminar el cold start.
