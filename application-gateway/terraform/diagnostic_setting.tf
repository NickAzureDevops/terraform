resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name               = "app-gw-diagnostic_settings"
  target_resource_id = azurerm_application_gateway.app_gw.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.Log_Analytics_WorkSpace.id

  dynamic "log" {
    for_each = local.diag_appgw_logs
    content {
      category = log.value

      retention_policy {
        enabled = true
        days    = 7
  
      
    }
  }
  }

  dynamic "metric" {
    for_each = local.diag_appgw_metrics
    content {
      category = metric.value

      retention_policy {
        enabled = false
      }
    }
  }
}

