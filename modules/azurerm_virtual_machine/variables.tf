variable "vm_name" {
  description = "The name of the Virtual Machine."
  type        = string
}
variable "rg_name" {
  description = "The name of the resource group."
  type        = string
}
variable "location" {
  description = "The Azure region where the Virtual Machine will be created."
  type        = string
}
variable "size" {
  description = "The size of the Virtual Machine."
  type        = string
}
variable "caching" {
  description = "The caching type for the OS disk."
  type        = string
}
variable "storage_account_type" {
  description = "The storage account type for the OS disk."
  type        = string
}
variable "publisher" {
  description = "The publisher of the OS image."
  type        = string
}
variable "offer" {
  description = "The offer of the OS image."
  type        = string
}
variable "sku" {
  description = "The SKU of the OS image."
  type        = string
}
# variable "version" {
#   description = "The version of the OS image."
 
# }

variable "nic_name" {
  description = "The name of the Network Interface."
  type        = string
 }
 variable "subnet_name" {
  description = "The name of the subnet where the Virtual Machine will be deployed."
  type        = string
 }
variable "vnet_name" {
  description = "The name of the Virtual Network where the subnet is located."
  type        = string
}

variable "public_ip_name" {
  description = "The name of the Public IP address associated with the Virtual Machine."
  type        = string
}

variable "key_vault_name" {
    description = "values for the Key Vault."
    type = string
  
}

variable "vm_username_secret_name" {
    description = "The name of the Key Vault secret for the VM username."
    type = string 
}

variable "vm_password_secret_name" {
    description = "The name of the Key Vault secret for the VM password."
    type = string 
}

