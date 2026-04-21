# EJ-AZ-03: Crear una Storage Account y Contenedor Blob

## 🎯 Objetivo
Crear una cuenta de almacenamiento en Azure y un contenedor Blob para almacenar archivos en la nube de forma segura y escalable.

## 📋 Conceptos Clave
- **Storage Account:** Espacio de almacenamiento único con múltiples servicios: Blob, Files, Queues, Tables.
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

### Paso 1: Revisar la variable del nombre
El nombre de la Storage Account debe ser **único globalmente**. Edita `variables.tf` y cambia el valor de `storage_account_name` por uno propio (ej: `sutectuapellido01`).

### Paso 2: Aplicar
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### Paso 3: Subir un archivo de prueba
```bash
# Con Azure CLI
az storage blob upload \
  --account-name <nombre_storage> \
  --container-name archivos-utec \
  --name test.txt \
  --file ./README.md \
  --auth-mode login
```

### Paso 4: Ver los outputs
```bash
terraform output blob_endpoint
```

### Paso 5: Destruir
```bash
terraform destroy -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:
blob_endpoint        = "https://suteclab01.blob.core.windows.net/"
storage_account_name = "suteclab01"
```

## 📝 Notas
- El nombre debe tener entre 3 y 24 caracteres, solo minúsculas y números.
- `container_access_type = "private"` asegura que los blobs no sean públicos.
- Usa `sensitive = true` en outputs que contengan claves de acceso.
