provider "azurerm" {
    version = "2.0"
    subscription_id = var.subscription_id
}
resource "azurerm_network_security_group" "CloudSkills12G" {

    name = "CloudSkills12G"
    location = "westus"
    resource_group_name = var.resource_group_name    
}
