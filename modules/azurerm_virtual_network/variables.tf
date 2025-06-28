variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}
variable "vnet_location" {
  description = "The Azure location where the virtual network will be created."
  type        = string
}
variable "rg_name" {
  description = "The name of the resource group where the virtual network will be created."
  type        = string
}   
variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
}