variable "resource_group" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
    type        = string
    description = "Location for all resources"
}

variable "admin_username" {
    type = string
    description = "Administrator username for server"
}

variable "admin_password" {
    type = string
    description = "Administrator password for server"
}

variable "servername" {
    type = string
    description = "Server name of the virtual machine"
}

variable "vm_size" {
    type = string
    description = "Size of VM"
    default = "Standard_B1s"
}

variable "os" {
    description = "OS image to deploy"
    type = object({
        publisher = string
        offer = string
        sku = string
        version = string
  })
}      
