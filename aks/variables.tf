variable "name" {
  description = "Name of Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure location of network components"
  default     = "UKSouth"
}

variable "kubernetes_cluster_rbac_enabled" {
  default = "true"
}

variable "kubernetes_version" {
}

variable "agent_count" {
}

variable "vm_size" {
}

variable "addons" {
  description = "Defines which addons will be activated."
  type = object({
    oms_agent                   = bool
    ingress_application_gateway = bool
  })
}