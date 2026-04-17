output "vm_names" {
  value = { for k, vm in azurerm_windows_virtual_machine.vm : k => vm.name }
}

output "public_ips" {
  value = { for k, pip in azurerm_public_ip.pip : k => pip.ip_address }
}

output "nic_ids" {
  value = { for k, nic in azurerm_network_interface.nic : k => nic.id }
}