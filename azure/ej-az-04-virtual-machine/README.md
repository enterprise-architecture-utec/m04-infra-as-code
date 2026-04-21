# EJ-AZ-04: Crear una Máquina Virtual Linux en Azure

## 🎯 Objetivo
Desplegar una VM Linux Ubuntu 22.04 en Azure con IP pública, interfaz de red y grupo de seguridad (NSG), usando Terraform de forma modular.

## 📋 Conceptos Clave
- **NIC (Network Interface Card):** Interfaz de red que conecta la VM a la VNet/Subnet.
- **Public IP:** Dirección IP pública estática o dinámica para acceso externo.
- **NSG (Network Security Group):** Firewall a nivel de subred o NIC que controla tráfico.
- **`Standard_B1s`:** Tamaño de VM económico: 1 vCPU, 1 GB RAM — ideal para labs.

## 📁 Archivos
```
ej-az-04-virtual-machine/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Pre-requisitos
Asegúrate de tener creados los recursos de los ejercicios AZ-01 y AZ-02 (Resource Group y Subnet).

### Paso 2: Aplicar
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### Paso 3: Conectarse por SSH
```bash
# Obtener IP pública
terraform output vm_public_ip

# Conectarse
ssh adminutec@<IP_PUBLICA>
# Password: P@ssw0rd1234!
```

### Paso 4: Destruir
```bash
terraform destroy -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:
vm_name      = "vm-utec-lab04"
vm_public_ip = "20.X.X.X"
vm_size      = "Standard_B1s"
```

## 📝 Notas
- En **producción** usa pares de claves SSH en lugar de contraseña (`admin_ssh_key` block).
- `Standard_B1s` es elegible para el Free Tier de Azure (750 horas/mes).
- El NSG permite SSH (puerto 22) desde cualquier IP — en prod restringe a tu IP.
