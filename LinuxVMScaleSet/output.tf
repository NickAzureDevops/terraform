output "resource_group_name" {
  value = azurerm_resource_group.vm_scaleset.name
}

output "vmss_public_ip_fqdn" {
   value = azurerm_public_ip.vm_scaleset.fqdn
}
