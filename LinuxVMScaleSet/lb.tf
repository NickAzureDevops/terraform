resource "azurerm_public_ip" "vm_scaleset" {
  name                = "vmss-publicip"
  location            = var.location
  resource_group_name = azurerm_resource_group.vm_scaleset.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "vm_scaleset" {
  name                = "vmss-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.vm_scaleset.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.vm_scaleset.id
  }
}