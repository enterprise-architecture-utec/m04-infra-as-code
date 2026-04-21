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

### Paso 1: Asegúrate de tener el RG del ejercicio AZ-01
Este ejercicio depende del Resource Group `rg-utec-lab01`. Si lo destruiste, vuelve a crearlo o ajusta la variable `resource_group_name`.

### Paso 2: Inicializar y aplicar
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### Paso 3: Verificar en Azure Portal
1. Ir a **Virtual Networks**
2. Seleccionar `vnet-utec-lab02`
3. En **Subnets**, verificar que existe `snet-privada` con CIDR `10.0.1.0/24`

### Paso 4: Explorar con Terraform
```bash
terraform output
terraform show
terraform graph | dot -Tpng > grafo.png  # Requiere graphviz
```

### Paso 5: Destruir
```bash
terraform destroy -auto-approve
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
- El CIDR de la VNet (`10.0.0.0/16`) debe contener el CIDR de todas sus subnets.
- Una subnet no puede solaparse con otra dentro de la misma VNet.
- Usa `terraform graph` para visualizar las dependencias entre recursos.
