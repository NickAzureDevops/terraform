# Create resourcegroup
resource "azurerm_resource_group" "vm_scaleset" {
# name     = "${var.name}-rg"
  name     = format("rg-wmss.%s", var.name)
  location = var.location

}

resource "azurerm_virtual_network" "vm_scaleset" {
  name                = "vnet-${var.name}-${azurerm_resource_group.vm_scaleset.location}-vmss"
  address_space       = var.v_netaddress_space
  location            = azurerm_resource_group.vm_scaleset.location
  resource_group_name = azurerm_resource_group.vm_scaleset.name
}

resource "azurerm_subnet" "internal" {
  name                 = "snet-${var.name}-${azurerm_resource_group.vm_scaleset.location}-vmss"
  resource_group_name  = azurerm_resource_group.vm_scaleset.name
  virtual_network_name = azurerm_virtual_network.vm_scaleset.name
  address_prefixes     = var.snet_address_space
}

resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                            = "${var.hostname}-vmss"
  resource_group_name             = azurerm_resource_group.vm_scaleset.name
  location                        = azurerm_resource_group.vm_scaleset.location
  sku                             = "Standard_F2"
  instances                       = 3
  admin_username                  = var.admin_user
  admin_password                  = var.admin_password
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.internal.id
    }
  }
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}