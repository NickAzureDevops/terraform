provider "azurerm" {
    version = "3.0.2"
    features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-learning"
    storage_account_name = "saterraformdevops"
    container_name       = "terraformdemo"
    key                  = "terraform.tfstate"
  }
}