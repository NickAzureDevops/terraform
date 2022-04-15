# Create Log Analtics Workspace

resource "azurerm_log_analytics_workspace" "log" {
    name                = "${var.name}-log"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "test" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.log.location
    resource_group_name   = azurerm_resource_group.rg.name
    workspace_resource_id = azurerm_log_analytics_workspace.log.id
    workspace_name        = azurerm_log_analytics_workspace.log.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}