resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_static_site" "rg" {
  name = var.blog_name
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location

}

resource "azurerm_application_insights" "rg" {
  
  name                = var.applicationinsights_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
  
    depends_on = [
    azurerm_resource_group.rg ]
}