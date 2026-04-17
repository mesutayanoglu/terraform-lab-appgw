resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "subnet_vm" {
  name                 = var.subnet_vm_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_vm_prefix]
}

resource "azurerm_subnet" "subnet_appgw" {
  name                 = var.subnet_appgw_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_appgw_prefix]
}