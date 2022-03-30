resource "azurerm_resource_group" "LinuxScaleSet" {
  name     = var.resourceGroupName
  location = "West Europe"
}

resource "azurerm_virtual_network" "LinuxScaleSet" {
  name                = "acctvn"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.LinuxScaleSet.location
  resource_group_name = azurerm_resource_group.LinuxScaleSet.name
}

resource "azurerm_subnet" "LinuxScaleSet" {
  name                 = "acctsub"
  resource_group_name  = azurerm_resource_group.LinuxScaleSet.name
  virtual_network_name = azurerm_virtual_network.LinuxScaleSet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "LinuxScaleSet" {
  name                = "test"
  location            = azurerm_resource_group.LinuxScaleSet.location
  resource_group_name = azurerm_resource_group.LinuxScaleSet.name
  allocation_method   = "Static"
  domain_name_label   = azurerm_resource_group.LinuxScaleSet.name

  tags = {
    environment = "staging"
  }
}

resource "azurerm_lb" "LinuxScaleSet" {
  name                = "test"
  location            = azurerm_resource_group.LinuxScaleSet.location
  resource_group_name = azurerm_resource_group.LinuxScaleSet.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.LinuxScaleSet.id
  }
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  resource_group_name = azurerm_resource_group.LinuxScaleSet.name
  loadbalancer_id     = azurerm_lb.LinuxScaleSet.id
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_nat_pool" "lbnatpool" {
  resource_group_name            = azurerm_resource_group.LinuxScaleSet.name
  name                           = "ssh"
  loadbalancer_id                = azurerm_lb.LinuxScaleSet.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_probe" "LinuxScaleSet" {
  resource_group_name = azurerm_resource_group.LinuxScaleSet.name
  loadbalancer_id     = azurerm_lb.LinuxScaleSet.id
  name                = "http-probe"
  protocol            = "Http"
  request_path        = "/health"
  port                = 8080
}

resource "azurerm_virtual_machine_scale_set" "LinuxScaleSet" {
  name                = "mytestscaleset-1"
  location            = azurerm_resource_group.LinuxScaleSet.location
  resource_group_name = azurerm_resource_group.LinuxScaleSet.name

  # automatic rolling upgrade
  automatic_os_upgrade = true
  upgrade_policy_mode  = "Rolling"

  rolling_upgrade_policy {
    max_batch_instance_percent              = 20
    max_unhealthy_instance_percent          = 20
    max_unhealthy_upgraded_instance_percent = 5
    pause_time_between_batches              = "PT0S"
  }

  # required when using rolling upgrade policy
  health_probe_id = azurerm_lb_probe.example.id

  sku {
    name     = "Standard_F2"
    tier     = "Standard"
    capacity = 2
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 10
  }

  os_profile {
    computer_name_prefix = "testvm"
    admin_username       = "myadmin"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/myadmin/.ssh/authorized_keys"
      key_data = file("~/.ssh/demo_key.pub")
    }
  }

  network_profile {
    name    = "terraformnetworkprofile"
    primary = true

    ip_configuration {
      name                                   = "TestIPConfiguration"
      primary                                = true
      subnet_id                              = azurerm_subnet.example.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
      load_balancer_inbound_nat_rules_ids    = [azurerm_lb_nat_pool.lbnatpool.id]
    }
  }

  tags = {
    environment = "staging"
  }
}