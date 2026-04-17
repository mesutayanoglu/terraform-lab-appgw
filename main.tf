terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "rg" {
  source   = "./modules/rg"
  rg_name  = var.rg_name
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  vnet_name           = var.vnet_name
  location            = var.location
  rg_name             = var.rg_name
  vnet_address_space  = var.vnet_address_space
  subnet_vm_prefix    = var.subnet_vm_prefix
  subnet_appgw_prefix = var.subnet_appgw_prefix
  subnet_vm_name = var.subnet_vm_name
  subnet_appgw_name = var.subnet_appgw_name
  depends_on = [module.rg]

}

module "nsg" {
  source       = "./modules/nsg"
  nsg_name     = var.nsg_name
  location     = var.location
  rg_name      = var.rg_name
  subnet_virtual_machines_id = module.vnet.subnet_vm_id
  depends_on = [module.rg]

}

module "vm" {
  source       = "./modules/vm"
  location     = var.location
  rg_name      = var.rg_name
  subnet_vm_id = module.vnet.subnet_vm_id
  vm_username  = var.vm_username
  vm_password  = var.vm_password
  vms          = var.vms
  depends_on = [module.rg]

}

module "appgw" {
  source          = "./modules/appgw"
  appgw_name      = var.appgw_name
  location        = var.location
  rg_name         = var.rg_name
  subnet_appgw_id = module.vnet.subnet_appgw_id
  nic_ids         = module.vm.nic_ids
  depends_on = [module.rg]

}