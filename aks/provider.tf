provider "azurerm" {
  version = "3.1.0"
  features {}
}
provider "azuread" {
}
provider "kubernetes" {
  host = azurerm_kubernetes_cluster.default.kube_config.0.host

  client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
}

data "azurerm_subscription" "current" {}
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-prd01"
    storage_account_name = "saterraformdevops"
    container_name       = "tfstate"
    key                  = "aks.tfstate"
  }
}