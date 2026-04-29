# EJ-AZ-02: Crear una Virtual Network (VNet) y Subnet

## 🎯 Objetivo
Aprovisionar una red virtual con una subred privada en Azure usando Terraform. La VNet es la base de toda arquitectura de red en Azure.

## 📋 Conceptos Clave
- **VNet:** Red privada virtual aislada en Azure, equivalente a una red on-premise.
- **Subnet:** Segmento de red dentro de la VNet con su propio rango de IPs (CIDR).
- **CIDR:** Notación de bloque de IPs. Ejemplo: `10.0.0.0/16` = 65,536 direcciones.

## 📁 Archivos
```
ej-az-02-vnet-subnet/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Asegúrate de tener el RG asignado
Este ejercicio depende del Resource Group asignado a cada alumno por ejm `mod3lab2`.

### Paso 2: Inicializar y aplicar
Deberás pasar tu nombre, tu ID (para el segmento de red) y el nombre exacto de tu RG.
```bash
terraform init

terraform plan \
  -var="student_name=XXXX" \
  -var="student_id=XXX" \
  -var="resource_group_name=XXXX"

terraform apply \
  -var="student_name=XXXX" \
  -var="student_id=XXX" \
  -var="resource_group_name=XXXX" \
  -auto-approve
```

### Paso 3: Verificar en Azure Portal
1. Ir a **Virtual Networks**
2. Seleccionar la VNet que lleva tu nombre: vnet-utec-tu_nombre.
3. En Subnets, verificar que el rango IP corresponde a tu ID: `10.[tu_id].1.0/24`.

### Paso 4: Explorar con Terraform
```bash
terraform output
terraform show
terraform graph | dot -Tpng > grafo.png  # Requiere graphviz
```

### Paso 5: Destruir
```bash
terraform destroy \
  -var="student_name=tu_nombre" \
  -var="student_id=tu_id" \
  -var="resource_group_name=tu_rg" \
  -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:
subnet_id      = "/subscriptions/.../subnets/snet-privada"
vnet_id        = "/subscriptions/.../virtualNetworks/vnet-utec-lab02"
vnet_name      = "vnet-utec-lab02"
```

## 📝 Notas
- Al usar un bloque data para el Resource Group, Terraform no intentará crearlo ni borrarlo, solo leerá su ubicación.
- Importante: Si el nombre del RG no es exacto al que aparece en el portal, el comando fallará con un error de `ResourceGroupNotFound`.
- Usa `terraform graph` para visualizar las dependencias entre recursos.
