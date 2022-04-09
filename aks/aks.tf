resource "azurerm_resource_group" "default" {
  name     = "${var.name}-rg"
  location = var.location

  tags = {
    environment = "testing"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "cluster-${var.name}-${azurerm_resource_group.default.location}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${var.name}-dnsazure"
  kubernetes_version  = var.kubernetes_version

  node_resource_group = "${var.name}-node-rg"

  default_node_pool {
    name            = "agent"
    node_count      = var.agent_count
    vm_size         = var.vm_size
    os_disk_size_gb = 30
    orchestrator_version = var.kubernetes_version

  }
 
   identity {
    type = "SystemAssigned"
  }
 

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "azure"
  }


  role_based_access_control_enabled = true


  tags = {
    environment = "Demo"
  }
}

