variable "name" {
  type        = string
  description = "name of resource"
}

variable "location" {
  type        = string
  description = "location of resoure"
}


variable "environment" {
  type = string
}

variable "enable_autoscale" {
  type        = bool
  default     = false
}

variable "app_plan_autoscale" {
  type = map(object({
    name            = string
    target_resource = string
    metric_resource = string
  }))
}

variable "profile_recurrence_days" {
  type = list 
  description = "profile recurrence days "
}


variable "autoscale_rule" {
  type = list(object({
    metric_name      = string
    time_grain       = string
    statistic        = string
    time_window      = string
    time_aggregation = string
    operator         = string
    threshold        = number

    direction = string
    type      = string
    value     = number
    cooldown  = string
  }))
}


variable "autoscale_recurrence" {
  type = map(object({
    timezone = string
    days     = list(string)
    hours    = any
    minutes  = any
  }))
}

