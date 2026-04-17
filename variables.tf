variable "rg_name" {
  default = "rg-appgw-lab"
}

variable "location" {
  default = "westeurope"
}

variable "vnet_name" {
  default = "vnet-appgw-lab"
}

variable "vnet_address_space" {
  default = "10.0.0.0/16"
}

variable "subnet_vm_prefix" {
  default = "10.0.1.0/24"
}

variable "subnet_appgw_prefix" {
  default = "10.0.2.0/24"
}

variable "subnet_appgw_name" {
  default = "subnet-app-gateway"
}

variable "subnet_vm_name" {
  default = "subnet-virtual-machines"
}

variable "nsg_name" {
  default = "nsg-appgw-lab"
}

variable "vm_username" {}
variable "vm_password" {}

variable "vms" {
  default = {
    "vm-1" = { script_path = "./modules/vm/scripts/vm1-script.ps1" }
    "vm-2" = { script_path = "./modules/vm/scripts/vm2-script.ps1" }
  }
}

variable "appgw_name" {
  default = "appgw-lab"
}