data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault_secret" "secret_login" {
  name         = var.sql_admin_username_secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "secret_password" {
  name         = var.sql_admin_password_secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}