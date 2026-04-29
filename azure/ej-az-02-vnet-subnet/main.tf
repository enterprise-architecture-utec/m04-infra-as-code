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

# Referencia al Resource Group existente del alumno
data "azurerm_resource_group" "utec_rg" {
  name = var.resource_group_name
}

# VNet con CIDR dinámico: 10.[student_id].0.0/16
resource "azurerm_virtual_network" "vnet_utec" {
  name                = "vnet-utec-${var.student_name}"
  address_space       = ["${var.vnet_cidr_base}.${var.student_id}.0.0/16"]
  location            = data.azurerm_resource_group.utec_rg.location
  resource_group_name = data.azurerm_resource_group.utec_rg.name

  tags = {
    Entorno = "Laboratorio"
    Curso   = "Arquitectura Multinube"
    Alumno  = var.student_name
  }
}

# Subnet con CIDR dinámico: 10.[student_id].1.0/24
resource "azurerm_subnet" "subnet_privada" {
  name                 = "snet-privada-${var.student_name}"
  resource_group_name  = data.azurerm_resource_group.utec_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_utec.name
  address_prefixes     = ["${var.vnet_cidr_base}.${var.student_id}.1.0/24"]
}