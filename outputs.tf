output "vm_names" {
  value = module.vm.vm_names
}

output "public_ips" {
  value = module.vm.public_ips
}

output "appgw_public_ip" {
  value = module.appgw.appgw_public_ip
}