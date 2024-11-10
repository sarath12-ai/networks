# provider "azurerm" {
#   features {}
# }

# terraform {
#   backend "azurerm" {
#     resource_group_name   = azurerm_resource_group.rg.name
#     storage_account_name   = azurerm_storage_account.storage.name
#     container_name         = var.storage_container_name
#     key                    = "terraform.tfstate"
#   }
# }

# resource "azurerm_storage_account" "storage" {
#   name                     = "tfstatestg"
#   resource_group_name      = azurerm_resource_group.rg.name
#   location                 = azurerm_resource_group.rg.location
#   account_tier            = "Standard"
#   account_replication_type = "LRS"
# }

# resource "azurerm_storage_container" "container" {
#   name                  = "tfstatefiles"
#   storage_account_name  = azurerm_storage_account.storage.name
# }

provider "azurerm" {
  features {}
}

variable "resource_group_name" {
  default = "tf-linux-rg"
}

variable "location" {
  default = "west US"
}

variable "vm_name" {
  default = "tf-linux-vm"
}

variable "admin_username" {
  default = "azureuser"
}

# Generate SSH Key Pair
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vm_name}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/23"]
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.vm_name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Public IP Address
resource "azurerm_public_ip" "public_ip" {
  name                = "${var.vm_name}-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "Network-NSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"  # Use a suitable VM size

  admin_username = var.admin_username

  # Use the generated SSH public key
  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh_key.public_key_openssh
  }

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

# Output the public IP and private key path
output "public_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "private_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}



# resource "azurerm_virtual_network" "vnet" {
#   name                = "Network-VNET"
#   address_space       = ["10.0.0.0/23"]
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

# resource "azurerm_subnet" "subnet" {
#   name                 = "Infra-Subnet"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.0.1/24"]
# }

# resource "azurerm_public_ip" "pip" {
#   name                = "Network-PIP"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# resource "azurerm_network_interface" "nic" {
#   name                = "Network-NIC"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnet.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.pip.id
#   }
# }

# resource "azurerm_linux_virtual_machine" "vm" {
#   name                = "Network-Infra-VM"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   size                = "Standard_B1s"
#   admin_username      = var.admin_username
#   admin_password      = var.admin_password
#   network_interface_ids = [
#     azurerm_network_interface.nic.id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }

#   disable_password_authentication = false
# }
