# This module creates an Azure Public IP resource.
# It requires the following variables:
# - public_ip_name: The name of the public IP resource.
# - rg_name: The name of the resource group where the public IP will be created.
# - location: The Azure region where the public IP will be created.
# - allocation_method: The allocation method for the public IP (e.g., Static or Dynamic

resource "azurerm_public_ip" "pip" {
  name                = var.public_ip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.allocation_method
}
