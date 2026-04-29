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
  skip_provider_registration = true
}

# Referencia al RG existente del alumno
data "azurerm_resource_group" "utec_rg" {
  name = var.resource_group_name
}

# Storage Account con nombre único global (máx 24 chars)
resource "azurerm_storage_account" "sa_utec" {
  # Ejemplo: sautecjose01
  name                     = "sautec${var.student_name}${var.student_id}"
  resource_group_name      = data.azurerm_resource_group.utec_rg.name
  location                 = data.azurerm_resource_group.utec_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    versioning_enabled = true
  }

  tags = {
    Entorno = "Laboratorio"
    Curso   = "Arquitectura Multinube"
    Alumno  = var.student_name
  }
}

resource "azurerm_storage_container" "contenedor" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.sa_utec.name
  container_access_type = "private"
}