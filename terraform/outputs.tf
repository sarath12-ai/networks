output "public_ip" {
  description = "The public IP of the VM"
  value       = azurerm_public_ip.public_ip.ip_address
}
