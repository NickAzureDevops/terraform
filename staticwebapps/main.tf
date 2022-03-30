resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_static_site" "rg" {
  name = var.blog_name
  resource_group_name = var.resource_group_name
  location = var.location
}

resource "azurerm_application_insights" "rg" {
  name                = var.applicationinsights_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "azurerm_log_analytics_workspace" "rg" {
  name                = var.log_analytics_name
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "PerGB2018"
  retention_in_days   = "${var.retention_period}"
}


