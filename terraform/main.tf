provider "azurerm" {
  features {}
}

terraform {
  backend "local" {
    path = "./terraform.tfstate"  # This is the default path
  }
}
data "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
}
resource "azurerm_network_security_group" "nsg" {
  name                = "Network-NSG"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

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
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "Infra-Subnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "Network-NIC"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

 resource "azurerm_public_ip" "pip" {
   name                = "Network-PIP"
   location            = data.azurerm_resource_group.rg.location
   resource_group_name = data.azurerm_resource_group.rg.name
   allocation_method   = "Static"  # Change from "Dynamic" to "Static"
   sku                 = "Standard" # Add SKU to match Static allocation requirement
 }


resource "azurerm_linux_virtual_machine" "vm" {
  name                = "Network-Infra-VM"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
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
  name                = "networkacrnpyla" # Update to a valid alphanumeric name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Basic"
  admin_enabled       = true
}

