# EJ-AWS-05: Crear una Base de Datos RDS MySQL

## 🎯 Objetivo
Desplegar una instancia RDS con MySQL 8.0 en una subred privada de AWS, con su DB Subnet Group y Security Group correspondientes.

## 📋 Conceptos Clave
- **RDS (Relational Database Service):** Base de datos relacional administrada en AWS.
- **DB Subnet Group:** Grupo de subnets en distintas AZs donde RDS puede desplegar la instancia.
- **Multi-AZ:** Alta disponibilidad mediante réplica automática en otra Availability Zone.
- **`db.t3.micro`:** Tipo de instancia de base de datos elegible para Free Tier.

## 📁 Archivos
```
ej-aws-05-rds/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Pre-requisito
Necesitas la VPC del ejercicio AWS-01. La subnet pública se usará para el DB Subnet Group (en producción usarías subnets privadas en múltiples AZs).

### Paso 2: Aplicar
```bash
terraform init
terraform plan
terraform apply -auto-approve
# ⏱️ RDS tarda entre 5-10 minutos en estar disponible
```

### Paso 3: Conectarse a la base de datos
```bash
ENDPOINT=$(terraform output -raw rds_endpoint)

# Desde una instancia EC2 dentro de la misma VPC
mysql -h $ENDPOINT -u adminutec -p utecdb
# Password: P@ssw0rd1234!
```

### Paso 4: Ejecutar consultas de prueba
```sql
SHOW DATABASES;
USE utecdb;
CREATE TABLE cursos (id INT PRIMARY KEY, nombre VARCHAR(100), creditos INT);
INSERT INTO cursos VALUES (1, 'Arquitectura Multinube', 4);
SELECT * FROM cursos;
```

### Paso 5: Destruir
```bash
terraform destroy -auto-approve
# ⏱️ RDS también tarda varios minutos en eliminarse
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:
db_name      = "utecdb"
rds_endpoint = "rds-utec-lab05.abc123.us-east-1.rds.amazonaws.com:3306"
rds_port     = 3306
rds_username = "adminutec"
```

## 📝 Notas
- `skip_final_snapshot = true` es conveniente en laboratorios pero nunca lo uses en producción.
- `db.t3.micro` es elegible para Free Tier (750 horas/mes durante 12 meses).
- `publicly_accessible = false` significa que la BD solo es accesible desde dentro de la VPC.
