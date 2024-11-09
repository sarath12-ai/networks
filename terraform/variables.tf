variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "myResourceGroup"
}

variable "location" {
  description = "Azure region to deploy resources"
  default     = "East US"
}

variable "vnet_name" {
  description = "Virtual Network name"
  default     = "myVNet"
}

variable "subnet_name" {
  description = "Subnet name"
  default     = "mySubnet"
}

variable "nic_name" {
  description = "Network Interface name"
  default     = "myNIC"
}

variable "vm_name" {
  description = "Virtual Machine name"
  default     = "myVM"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for the VM"
  default     = "P@ssword1234!"
}
