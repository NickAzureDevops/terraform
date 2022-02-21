module "vm" {
   source  = "crayon/vm/azurerm"
   version = "1.11.0"

    name = "vm-augs-demo"
    resource_group = azurerm_resource_group.demo.name
    location = azurerm_resource_group.demo.location

    network_interface_subnets = [{
    name                 = azurerm_subnet.demo.name
    virtual_network_name = azurerm_virtual_network.demo.name
    resource_group_name  = azurerm_resource_group.demo.name
    public_ip_id         = null
    static_ip            = null
  }]

    admin_user = {
    username = "crayonadm"
    ssh_key  = file("~/.ssh/id_rsa.pub")
  }

    depends_on = [
    azurerm_resource_group.demo
  ]
}
