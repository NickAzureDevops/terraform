locals {
  name = "Blog"
  location = "UKSouth"
}

resource "azurerm_resource_group" "rg" {
  name = "rg-${local.name}-prod-${local.location}"
  location = local.location
  tags = local.common_tags
}

resource "azurerm_static_site" "web" {
  name = "web-${local.name}-prod-${local.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location = local.location
  tags = local.common_tags
}