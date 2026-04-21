terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "utec_rg" {
  name = var.resource_group_name
}

# Servidor SQL Logico
resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = data.azurerm_resource_group.utec_rg.name
  location                     = data.azurerm_resource_group.utec_rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password

  tags = {
    Entorno = "Laboratorio"
    Curso   = "Arquitectura Multinube"
  }
}

# Base de Datos
resource "azurerm_mssql_database" "db_utec" {
  name      = var.database_name
  server_id = azurerm_mssql_server.sql_server.id

  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "Basic"
}

# Regla de Firewall para acceso desde Azure Services
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Regla de Firewall para acceso desde tu IP local
# Descomenta y ajusta tu IP antes de aplicar
# resource "azurerm_mssql_firewall_rule" "allow_my_ip" {
#   name             = "AllowMyIP"
#   server_id        = azurerm_mssql_server.sql_server.id
#   start_ip_address = "TU.IP.AQUI.0"
#   end_ip_address   = "TU.IP.AQUI.0"
# }
