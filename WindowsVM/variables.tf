variable "resource_group" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
    type        = string
    description = "Location for all resources"
}


variable "server_name" {
    type        = string
    description = "server name"
}


variable "admin_username" {
    type = string
    description = "Administrator username for server"
}

variable "admin_password" {
    type = string
    description = "Administrator password for server"
}

variable "managed_disk_type" { 
    type = map
    description = "Disk type Premium in Primary location Standard in DR location"

    default = {
        westus2 = "Premium_LRS"
        eastus = "Standard_LRS"
    }
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
variable "secret_name" {
    type = string
    description = "Keyvaault secret"
}
