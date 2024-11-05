output "public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "vm_name" {
  value = azurerm_virtual_machine.vm.name
  description = "The name of the virtual machine."
}
# output "acr_login_server" {
#   value = azurerm_container_registry.acr.login_server
# }

# output "acr_admin_username" {
#   value = azurerm_container_registry.acr.admin_username
# }

# output "acr_admin_password" {
#   value     = azurerm_container_registry.acr.admin_password
#   sensitive = true
# }
