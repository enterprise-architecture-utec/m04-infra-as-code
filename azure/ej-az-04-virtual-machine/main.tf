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

data "azurerm_subnet" "subnet_privada" {
  name                 = "snet-privada"
  virtual_network_name = "vnet-utec-lab02"
  resource_group_name  = var.resource_group_name
}

# IP Publica para la VM
resource "azurerm_public_ip" "pip_vm" {
  name                = "pip-utec-vm01"
  resource_group_name = data.azurerm_resource_group.utec_rg.name
  location            = data.azurerm_resource_group.utec_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Network Security Group con regla SSH
resource "azurerm_network_security_group" "nsg_vm" {
  name                = "nsg-utec-vm01"
  location            = data.azurerm_resource_group.utec_rg.location
  resource_group_name = data.azurerm_resource_group.utec_rg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Interfaz de Red
resource "azurerm_network_interface" "nic_vm" {
  name                = "nic-utec-vm01"
  location            = data.azurerm_resource_group.utec_rg.location
  resource_group_name = data.azurerm_resource_group.utec_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet_privada.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_vm.id
  }
}

# Asociar NSG a la NIC
resource "azurerm_network_interface_security_group_association" "nsg_nic" {
  network_interface_id      = azurerm_network_interface.nic_vm.id
  network_security_group_id = azurerm_network_security_group.nsg_vm.id
}

# Maquina Virtual Linux
resource "azurerm_linux_virtual_machine" "vm_utec" {
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.utec_rg.name
  location            = data.azurerm_resource_group.utec_rg.location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [azurerm_network_interface.nic_vm.id]

  admin_password                  = var.admin_password
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    Entorno = "Laboratorio"
    Curso   = "Arquitectura Multinube"
  }
}
