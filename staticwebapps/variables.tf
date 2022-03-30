variable "resource_group_name" {
    type        = string
    description = "Resource group name"
}

variable "blog_name" {
    type        = string
    description = "Blog name"
}
variable "location" {
    default = "West Europe"
}
variable "log_analytics_name" {
  default = "log-blog-prd"
}

variable "applicationinsights_name" {
  default = "appinsights-blog"
}

variable "retention_period" {
  default = "30"
}