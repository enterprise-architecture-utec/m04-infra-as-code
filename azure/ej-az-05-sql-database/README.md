# EJ-AZ-05: Crear una Azure SQL Database

## 🎯 Objetivo
Aprovisionar un servidor SQL administrado y una base de datos en Azure usando Terraform, sin gestionar infraestructura de servidores.

## 📋 Conceptos Clave
- **Azure SQL Server:** Servidor lógico que aloja una o más bases de datos SQL.
- **Azure SQL Database:** Base de datos relacional administrada (PaaS) compatible con T-SQL.
- **SKU Basic:** Tier económico de Azure SQL — ideal para laboratorios y desarrollo.
- **Firewall Rule:** Regla que permite el acceso desde IPs específicas al servidor SQL.

## 📁 Archivos
```
ej-az-05-sql-database/
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

### Paso 2: Conectarse con Azure Data Studio o SSMS
```
Servidor:  <sql_server_fqdn del output>
Usuario:   sqladminUtec
Password:  P@ssw0rd1234!
Base de datos: db-utec-laboratorio
```

### Paso 3: Ejecutar una consulta de prueba
```sql
SELECT @@VERSION;
CREATE TABLE estudiantes (id INT, nombre VARCHAR(100));
INSERT INTO estudiantes VALUES (1, 'Juan Perez');
SELECT * FROM estudiantes;
```

### Paso 4: Agregar regla de firewall para tu IP
```bash
# Obtener tu IP publica
curl ifconfig.me

# Agregar al archivo main.tf el recurso de firewall
# (ya incluido como ejemplo comentado en main.tf)
```

### Paso 5: Destruir
```bash
terraform destroy -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:
database_name   = "db-utec-laboratorio"
sql_server_fqdn = "sql-utec-lab05.database.windows.net"
sql_server_name = "sql-utec-lab05"
```

## 📝 Notas
- El nombre del SQL Server debe ser único globalmente en Azure.
- En producción, nunca pongas contraseñas en el código — usa Azure Key Vault o variables de entorno.
- SKU `Basic` tiene 5 DTUs y 2 GB de almacenamiento máximo.
