# EJ-AZ-03: Crear una Storage Account y Contenedor Blob

## 🎯 Objetivo
Crear una cuenta de almacenamiento en Azure y un contenedor Blob para almacenar archivos en la nube de forma segura y escalable.

## 📋 Conceptos Clave
- **Storage Account:** Espacio de almacenamiento único con múltiples servicios: Blob, Files, Queues, Tables. Solo permite minúsculas y números (máx 24 caracteres).
- **Blob Container:** Contenedor de objetos (archivos) dentro de una Storage Account.
- **LRS:** Locally Redundant Storage — 3 copias en el mismo datacenter.
- **Variables de entrada:** Permiten parametrizar el código para reutilizarlo.

## 📁 Archivos
```
ej-az-03-storage-account/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos



### Paso 2: Aplicar
```bash
terraform init

terraform plan \
  -var="student_name=XXX" \
  -var="student_id=XX" \
  -var="resource_group_name=XXXX" \
  -auto-approve


terraform apply \
  -var="student_name=XXX" \
  -var="student_id=XX" \
  -var="resource_group_name=XXXX" \
  -auto-approve
```

### Paso 3: Subir un archivo de prueba
```bash
SA_NAME=$(terraform output -raw storage_account_name)

az storage blob upload \
  --account-name $SA_NAME \
  --container-name archivos-utec \
  --name test.txt \
  --file ./README.md \
  --auth-mode login
```


### Paso 5: Destruir
```bash
terraform destroy \
  -var="student_name=XXX" \
  -var="student_id=XX" \
  -var="resource_group_name=XXXX" \
  -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:
blob_endpoint        = "https://suteclab01.blob.core.windows.net/"
storage_account_name = "suteclab01"
```