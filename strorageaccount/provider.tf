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
      access_key = "1juF/1zlXgQpApvX2HQBKJRu2AgxJt1V4jefJ6LdoUFJWHmEJljbRnr7LJwjT0eKWlG4UWJ2vqTR+AStgYovDw=="
    }
}
