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

resource "azurerm_resource_group" "utec_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Entorno = "Laboratorio"
    Curso   = "Arquitectura Multinube"
    Modulo  = "Modulo 4 - IaC"
  }
}
