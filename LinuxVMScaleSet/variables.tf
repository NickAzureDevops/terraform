variable "name" {
  description = "Resource Group Name "
}

variable "location" {
  type        = string
  description = "Azure location of network resource"
  default     = "UK South"
}

variable "v_netaddress_space" {
  type        = list(any)
  description = "Address space for Virtual Network"
}

variable "snet_address_space" {
  type        = list(any)
  description = "Address space for Subnet"
}

variable "vnetwork_name" {
    description = "virtual network name"
    default = "vm"
}

variable "admin_user" {
   description = "User name to use as the admin account on the VMs that will be part of the VM scale set"
   default     = "azureuser"
}

variable "admin_password" {
   type = string
   description = "Default password for admin account"
}

variable "tags" {
   description = "Map of the tags to use for the resources that are deployed"
   type        = map(string)
   default = {
      environment = "staging"
   }
}
variable "hostname" {
   description = "Default password for admin account"
   default = "academyvm"
}