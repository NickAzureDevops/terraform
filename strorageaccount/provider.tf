provider "azurerm" {
    version = "~> 2.0"
    features {}
}

terraform {
    backend "azurerm" {
      resource_group_name = "terraform-learning"   
      storage_account_name = "saterraformdevops"
      container_name = "terraformdemo"
      key            = "dev.terraform.tfstate"
    }
}