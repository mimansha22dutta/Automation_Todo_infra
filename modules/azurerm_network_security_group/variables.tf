variable "location" {
  description = "The Azure location where the Network Security Group will be created."
  type        = string
}

variable "nsg_name" {
  description = "The name of the Network Security Group."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group where the Network Security Group will be created."
  type        = string
}

variable "nic_name" {
  description = "The name of the Network Interface to associate with the Network Security Group."
  type        = string
}