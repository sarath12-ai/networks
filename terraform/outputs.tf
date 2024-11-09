output "vm_id" {
  description = "The ID of the Virtual Machine"
  value       = azurerm_virtual_machine.vm.id
}

output "vm_ip_address" {
  description = "Public IP address of the Virtual Machine"
  value       = azurerm_virtual_machine.vm.public_ip_address
}
