# EJ-AZ-07: Crear un Azure Key Vault y gestionar Secretos

## 🎯 Objetivo
Crear un Key Vault en Azure para gestionar secretos, claves y certificados de forma segura. Key Vault es el estándar para evitar contraseñas hardcodeadas en el código.

## 📋 Conceptos Clave
- **Key Vault:** Servicio administrado para almacenar secretos, claves criptográficas y certificados.
- **Access Policy:** Define qué identidades (usuarios, apps) pueden realizar qué operaciones.
- **`data "azurerm_client_config"`:** Data source que recupera el Tenant ID y Object ID del usuario autenticado.
- **`sensitive = true`:** Oculta el valor del output en los logs de Terraform.

## 📁 Archivos
```
ej-az-07-key-vault/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Aplicar
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### Paso 2: Leer el secreto con Azure CLI
```bash
# Ver el valor del secreto (lo ocultará Terraform pero Azure CLI sí lo muestra)
az keyvault secret show \
  --vault-name kv-utec-lab07 \
  --name db-password \
  --query value -o tsv
```

### Paso 3: Agregar otro secreto vía CLI
```bash
az keyvault secret set \
  --vault-name kv-utec-lab07 \
  --name api-key \
  --value "mi-api-key-secreta"
```

### Paso 4: Destruir
```bash
terraform destroy -auto-approve
# Si falla por soft-delete, purgar manualmente:
az keyvault purge --name kv-utec-lab07
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:
key_vault_name = "kv-utec-lab07"
key_vault_uri  = "https://kv-utec-lab07.vault.azure.net/"
```

## 📝 Notas
- El nombre del Key Vault debe ser globalmente único, 3-24 caracteres alfanuméricos y guiones.
- `soft_delete_retention_days = 7` es el mínimo — los secretos se pueden recuperar dentro de ese período.
- En producción, usa **Managed Identity** en lugar de access policies para evitar gestión de credenciales.
