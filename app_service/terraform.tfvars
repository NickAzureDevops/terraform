name = "autoscale_test"
environment = "stagging"
location = "UKSouth"

enable_autoscale = true

app_plan_autoscale = {
  frontend_app = {
    name            = "frontendAutoscaleSetting"
    target_resource = "frontend"
    metric_resource = "frontend"
  },
  backend_app = {
    name            = "backendAutoscaleSetting"
    target_resource = "backend"
    metric_resource = "backend"
  },

  functionapp = {
    name            = "functionAutoscaleSetting"
    target_resource = "functions"
    metric_resource = "functions"
  }
}

profile_recurrence_days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

  autoscale_rule = [
    {
          
        metric_name        = "CpuPercentage"
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 80
  
        direction           = "Increase"
        type                = "ChangeCount"
        value               = "1"
        cooldown            = "PT1M"
}      
]

autoscale_recurrence = {
  recurrence = {
      timezone = "UTC"
      days     = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
      hours    = [0]
      minutes  = [0]
}
}
