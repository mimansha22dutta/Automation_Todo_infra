variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}
variable "rg_name" {
  description = "The name of the resource group where the subnet will be created."
  type        = string
}
variable "vnet_name" {
  description = "The name of the virtual network where the subnet will be created."
  type        = string
}
variable "address_prefixes" {
  description = "The address prefixes for the subnet."
  type        = list(string)
}