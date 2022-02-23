provider "azurerm" {
    version = "~> 2.0"
    features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraformsf"
    storage_account_name = "storagestprd001"
    container_name       = "tfstate"
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group
  location = var.location
  
}

# Create virtual network
resource "azurerm_virtual_network" "resource_group" {
  name                = "VM-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}
# Create subnet 

resource "azurerm_subnet" "resource_group" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.resource_group.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create public IP
resource "azurerm_public_ip" "publicip" {
  name                = "pip01"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"
}

# Create network interface 

resource "azurerm_network_interface" "resource_group" {
  name                = "terraformVM-nic"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.resource_group.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
    
      }
}

  # Create virtual machine
  resource "azurerm_virtual_machine" "vm" {
  name                  = var.server_name
  location              = azurerm_resource_group.resource_group.location
  resource_group_name   = azurerm_resource_group.resource_group.name
  network_interface_ids = [
    azurerm_network_interface.resource_group.id,
  ]
  vm_size               = "Standard_B1s"


  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = lookup(var.managed_disk_type, var.location, "Standard_LRS")

  }

  storage_image_reference {
    publisher = var.os.publisher
    offer     = var.os.offer
    sku       = var.os.sku
    version   = var.os.version
  }

  os_profile {
    computer_name  = var.server_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_windows_config {
  }
}
#Keyvault Creation
resource "azurerm_key_vault" "resource_group" {
  name                        = "kvaultprd01"
  location                    = azurerm_resource_group.resource_group.location
  resource_group_name         = azurerm_resource_group.resource_group.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}
  resource "azurerm_key_vault_access_policy" "resource_group" {
  key_vault_id = azurerm_key_vault.resource_group.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "Delete",
      "Purge",
      "List"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge"
    ]

    storage_permissions = [
      "Get",
      "List"
    ]
  }

resource "azurerm_key_vault_secret" "resource_group" {
  name         = var.secret_name
  value        = var.admin_password
  key_vault_id = azurerm_key_vault.resource_group.id
    depends_on = [azurerm_key_vault_access_policy.resource_group]

}