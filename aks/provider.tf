provider "azurerm" {
      version = "3.1.0"
      features {}
}  
  provider "azuread" {
}

data "azurerm_subscription" "current" {}
terraform {
    backend "azurerm" {
      resource_group_name = "terraform-learning"   
      storage_account_name = "saterraformdevops"
      container_name = "terraformdemo"
      key            = "dev.terraform.tfstate"
    }
}