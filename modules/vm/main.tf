resource "azurerm_public_ip" "pip" {
  for_each            = var.vms
  name                = "pip-${each.key}"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = "nic-${each.key}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_vm_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[each.key].id
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  for_each            = var.vms
  name                = each.key
  location            = var.location
  resource_group_name = var.rg_name
  size                = "Standard_B2ls_v2"
  zone                = "3"
  admin_username      = var.vm_username
  admin_password      = var.vm_password

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}