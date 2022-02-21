provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}

data "azurerm_client_config" "current" {}

terraform {
backend "azurerm" {
    resource_group_name  = "terraformsf"
    storage_account_name = "storagestprd001"
    container_name       = "tfstate"
    key                  = "dev.tfstate"
  }
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_virtual_network" "resource_group" {
  name                = "VM-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_subnet" "resource_group" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.resource_group.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "resource_group" {
  name                = "terraformVM-nic"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.resource_group.id
        private_ip_address_allocation = "Dynamic"
  }
}

  # Create virtual machine
resource "azurerm_virtual_machine" "vm" {
  name                  = var.servername
  location              = azurerm_resource_group.resource_group.location
  resource_group_name   = azurerm_resource_group.resource_group.name
  network_interface_ids = [
    azurerm_network_interface.resource_group.id,
  ]
  vm_size               = "Standard_B1s"


  storage_os_disk {
    name              = "stvm${var.servername}os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  storage_image_reference {
    publisher = var.os.publisher
    offer     = var.os.offer
    sku       = var.os.sku
    version   = var.os.version
  }

  os_profile {
    computer_name  = var.servername
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_windows_config {
  }

}