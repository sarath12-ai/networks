variable "subscription_id" {
  description = "Azure Subscription ID"
}

variable "resource_group_name" {
  description = "Resource group name"
  default     = "myResourceGroup"
}

variable "location" {
  description = "Azure region"
  default     = "East US"
}

variable "vm_name" {
  description = "Virtual machine name"
  default     = "myVM"
}

variable "admin_username" {
  description = "Admin username for the VM"
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "Path to SSH public key"
  default     = "./ssh_key.pub"
}
