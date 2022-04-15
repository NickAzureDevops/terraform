variable "name" {
  type        = string
  default     = "kubernetes"
  description = "Name for resources"
}

variable "location" {
  type        = string
  description = "Azure location of network components"
  default     = "UKSouth"
}

# variable "addons" {
#   description = "Defines which addons will be activated."
#   type = object({
#     oms_agent                   = bool
#     ingress_application_gateway = bool
#   })
# }

variable "kubernetes_cluster_rbac_enabled" {
  default = "true"
}

variable "kubernetes_version" {
}

variable "agent_count" {
}

variable "vm_size" {
}

variable "ssh_public_key"{
  description = "ssh key"

}

variable "azuread_object_id" {
}

