# EJ-AZ-01: Crear un Resource Group en Azure

## 🎯 Objetivo
Crear un Resource Group en Azure usando Terraform. Es el contenedor lógico base de todo recurso en Azure.

## 📋 Conceptos Clave
- **Resource Group:** Contenedor lógico que agrupa recursos relacionados en Azure.
- **Provider `azurerm`:** Plugin que permite a Terraform comunicarse con Azure.
- **Tags:** Metadatos clave-valor para organizar y clasificar recursos.

## 📁 Archivos
```
ej-az-01-resource-group/
├── main.tf        # Provider y resource group
├── variables.tf   # Variables de entrada
├── outputs.tf     # Valores de salida
└── README.md
```

## 🚀 Pasos

### Paso 1: Autenticarse en Azure
```bash
az login
az account show
```

### Paso 2: Inicializar Terraform
```bash
terraform init
```

### Paso 3: Planificar
```bash
terraform plan
```
> Deberías ver: `Plan: 1 to add, 0 to change, 0 to destroy.`

### Paso 4: Aplicar
```bash
terraform apply -auto-approve
```

### Paso 5: Verificar en Azure Portal
1. Ir a https://portal.azure.com
2. Buscar **Resource Groups**
3. Confirmar que `rg-utec-lab01` aparece en **East US**

### Paso 6: Ver outputs
```bash
terraform output
```

### Paso 7: Destruir al terminar
```bash
terraform destroy -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:
resource_group_id       = "/subscriptions/.../resourceGroups/rg-utec-lab01"
resource_group_location = "eastus"
resource_group_name     = "rg-utec-lab01"
```

## 📝 Notas
- El nombre del RG debe ser único dentro de la suscripción.
- La región `East US` se almacena como `eastus` (sin espacio) internamente.
- Los tags son opcionales pero son buena práctica para control de costos.
