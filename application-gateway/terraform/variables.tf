variable "name" {
  type        = string
  default     = "log-analytics-example"
  description = "Name for resources"
}

variable "location" {
  type        = string
  default     = "uksouth"
  description = "Azure Location of resources"
}

variable "backend_address_pool_name" {
    default = "BackendPool"
}

variable "frontend_port_name" {
    default = "Frontend"
}

variable "frontend_ip_configuration_name" {
    default = "frontend_IPConfig"
}

variable "http_setting_name" {
    default = "myHTTPsetting"
}

variable "listener_name" {
    default = "myListener"
}

variable "request_routing_rule_name" {
    default = "myRoutingRule"
}

variable "redirect_configuration_name" {
    default = "myRedirectConfig"
}

locals {

  diag_appgw_logs = [
    "ApplicationGatewayAccessLog",
    "ApplicationGatewayPerformanceLog",
    "ApplicationGatewayFirewallLog",
  ]
  diag_appgw_metrics = [
    "AllMetrics",
  ]
}