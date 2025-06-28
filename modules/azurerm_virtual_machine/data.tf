data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
}

data "azurerm_public_ip" "pip" {
  name                = var.public_ip_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault_secret" "username" {
  name         = var.vm_username_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
data "azurerm_key_vault_secret" "password" {
  name         = var.vm_password_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}