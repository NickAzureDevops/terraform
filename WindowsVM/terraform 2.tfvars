location        = "UKWest"
resource_group  = "terraformlab"
admin_username = "terraadmin"
server_name     = "dc2"
os = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
}
secret_name            = "DatabasePassword"

