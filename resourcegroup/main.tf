resource "azurerm_resource_group" "DevRG" {
  name     = var.resourceGroupName
  location = var.location

  tags = {
    environment = "Dev"
  }
}