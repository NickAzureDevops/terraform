terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.82.0"
    }
  }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "demo" {
    name     = "rg-augs-demo"
    location = "westeurope"

}

resource "azurerm_virtual_network" "demo" {
    name = "vnet-augs-demo"
    resource_group_name = azurerm_resource_group.demo.name
    location = azurerm_resource_group.demo.location
    address_space = [ "10.0.0.0/16" ]

}

resource "azurerm_subnet" "demo" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.demo.name
  virtual_network_name = azurerm_virtual_network.demo.name
  address_prefixes     = ["10.0.1.0/24"]

}