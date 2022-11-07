resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-rg"
  location = var.location
}
resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.name}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.name}-dnsazure"
  kubernetes_version  = var.kubernetes_version

  node_resource_group = "${var.name}-node-rg"

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = var.ssh_public_key
    }
  }
  default_node_pool {
    name                 = "agent"
    node_count           = var.agent_count
    vm_size              = var.vm_size
    vnet_subnet_id       = azurerm_subnet.vnet_subnet.id
    type                 = "VirtualMachineScaleSets"
    orchestrator_version = var.kubernetes_version
  }
  identity {
    type = "SystemAssigned"
  }
  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "azure"
  }
  role_based_access_control_enabled = var.kubernetes_cluster_rbac_enabled

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = [var.azuread_object_id]
  }

  oms_agent {

    log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id

  }
}

data "azurerm_resource_group" "node_resource_group" {
  name = azurerm_kubernetes_cluster.default.node_resource_group
  depends_on = [
    azurerm_kubernetes_cluster.default
  ]
}
resource "azurerm_role_assignment" "node_infrastructure_update_scale_set" {
  principal_id         = azurerm_kubernetes_cluster.default.kubelet_identity[0].object_id
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Virtual Machine Contributor"
  depends_on = [
    azurerm_kubernetes_cluster.default
  ]
}
