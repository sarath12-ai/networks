provider "azurerm" {
  features {}
}

terraform {
  backend "local" {
    path = "./terraform.tfstate"  # This is the default path
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "Network-NSG"
  location            = var.location
  resource_group_name = var.resource_group_name

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
}

resource "azurerm_virtual_network" "vnet" {
  name                = "Network-VNET"
  address_space       = ["10.0.0.0/16"]
   location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                 = "Infra-Subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "Network-NIC"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

 resource "azurerm_public_ip" "pip" {
   name                = "Network-PIP"
   location            = var.location
   resource_group_name = azurerm_resource_group.rg.name
   allocation_method   = "Static"  # Change from "Dynamic" to "Static"
   sku                 = "Standard" # Add SKU to match Static allocation requirement
 }


resource "azurerm_linux_virtual_machine" "vm" {
  name                = "Network-Infra-VM"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
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
disable_password_authentication = false
}

resource "azurerm_container_registry" "acr" {
  name                = "networkacrnaidupyla1" # Update to a valid alphanumeric name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  admin_enabled       = true
}

