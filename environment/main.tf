module "rg" {
  source = "../modules/azurerm_resource_group"
  rg_name     = "mim-resource-group"
  rg_location = "West Europe"
}

# second resource group for testing purposes
# This module creates a second resource group in Azure.
module "rg2" {
  source = "../modules/azurerm_resource_group"
  rg_name     = "mim-resource-group22"
  rg_location = "West Europe"
}


module "vnet" {
    depends_on = [module.rg]
    source = "../modules/azurerm_virtual_network"
    vnet_name        = "mim-vnet"
    vnet_location    = "West Europe"    
    rg_name          = "mim-resource-group"
    address_space    = ["10.0.0.0/16"]
}

module "frontend_subnet" {
   depends_on = [module.vnet]
   source = "../modules/azurerm_subnet"
   subnet_name      = "mim-frontend-subnet"
   rg_name          = "mim-resource-group"
   vnet_name = "mim-vnet"
   address_prefixes = ["10.0.1.0/24"]
}

module "backend_subnet" {
   depends_on = [module.vnet]
   source = "../modules/azurerm_subnet"
   subnet_name      = "mim-backend-subnet"
   rg_name          = "mim-resource-group"
   vnet_name = "mim-vnet"
   address_prefixes = ["10.0.0.0/24"]
}

module "public_ip_frontend" {
  depends_on = [module.rg]
  source = "../modules/azurerm_public_ip"
  public_ip_name = "mim-frontend-pip"
  rg_name = "mim-resource-group"
  location = "West Europe"
  allocation_method = "Static"
}

module "public_ip_backend" {
  depends_on = [module.rg]
  source = "../modules/azurerm_public_ip"
  public_ip_name = "mim-backend-pip"
  rg_name = "mim-resource-group"
  location = "West Europe"
  allocation_method = "Static"
}

module "frontend_vm"{
  depends_on = [module.frontend_subnet, module.public_ip_frontend, module.key_vault, module.vm_password, module.vm_username]
  source = "../modules/azurerm_virtual_machine"
  vm_name = "mim-frontend-vm"
  rg_name = "mim-resource-group"
  location = "West Europe"
  size = "Standard_B1s"
  # admin_username = data.azurerm_key_vault_secret.vm_username.value
  # admin_password = data.azurerm_key_vault_secret.vm_password.value
  caching = "ReadWrite"
  storage_account_type = "Standard_LRS"
  publisher = "Canonical"
  offer = "0001-com-ubuntu-server-jammy"
  sku = "22_04-lts"
  nic_name = "mim-frontend-nic"
  subnet_name = "mim-frontend-subnet"
  vnet_name = "mim-vnet"
  public_ip_name = "mim-frontend-pip"
  key_vault_name = "mim-key-vault-22"
  vm_username_secret_name = "vm-username"
  vm_password_secret_name = "vm-password"
}

module "backend_vm" {
  depends_on = [module.backend_subnet, module.public_ip_backend, module.key_vault, module.vm_password, module.vm_username]
  source = "../modules/azurerm_virtual_machine"
  vm_name = "mim-backend-vm"
  rg_name = "mim-resource-group"
  location = "West Europe"
  size = "Standard_B1s"
  # admin_username = data.azurerm_key_vault_secret.vm_username.value  
  # admin_password = data.azurerm_key_vault_secret.vm_password.value
  caching = "ReadWrite"
  storage_account_type = "Standard_LRS"
  publisher = "Canonical"
  offer = "0001-com-ubuntu-server-jammy"
  sku = "22_04-lts"
  nic_name = "mim-backend-nic"
  subnet_name = "mim-backend-subnet"
  vnet_name = "mim-vnet"
  public_ip_name = "mim-backend-pip"
  key_vault_name = "mim-key-vault-22"
  vm_username_secret_name = "vm-username"
  vm_password_secret_name = "vm-password"
}

module "sql_server" {
  depends_on = [ module.rg, module.key_vault, module.sql_login, module.sql_password ]
  source = "../modules/azurerm_sql_server"
  sql_server_name = "mim-sql-server-ne"
  rg_name         = "mim-resource-group"
  location        = "North Europe"
  # version = "12.0"
  key_vault_name = "mim-key-vault-22"
  sql_admin_username_secret_name = "sql-login"
  sql_admin_password_secret_name = "sql-password"
}

module "sql_db" {
  depends_on = [module.sql_server]
  source = "../modules/azurerm_sql_database"
  sql_db_name = "mim-sql-db"
  collation = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb = 50
  sku_name = "S0"
  sql_server_name = "mim-sql-server-ne"
  rg_name = "mim-resource-group"
}

module "key_vault" {
  depends_on = [module.rg]
  source = "../modules/azurerm_key_vault"
  key_vault_name = "mim-key-vault-22"
  rg_name = "mim-resource-group"
  location = "West Europe"
}

module "vm_username" {
  depends_on = [module.key_vault]
  source = "../modules/azurerm_key_vault_secret"
  rg_name = "mim-resource-group"
  key_vault_name = "mim-key-vault-22"
  secret_name = "vm-username"
  secret_value = "azureuser"
}

module "vm_password"{
  depends_on = [module.key_vault]
  source = "../modules/azurerm_key_vault_secret"
  rg_name = "mim-resource-group"
  key_vault_name = "mim-key-vault-22"
  secret_name = "vm-password"
  secret_value = "P@ssw0rd1234!"
}

module "sql_login" {
  depends_on = [module.key_vault]
  source = "../modules/azurerm_key_vault_secret"
  rg_name  = "mim-resource-group"
  key_vault_name = "mim-key-vault-22"
  secret_name = "sql-login"
  secret_value = "missadministrator"
}

module "sql_password" {
  depends_on = [module.key_vault]
  source = "../modules/azurerm_key_vault_secret"
  rg_name  = "mim-resource-group"
  key_vault_name = "mim-key-vault-22"
  secret_name = "sql-password"
  secret_value = "thisIsKat11"
}

module "frontend_nsg" {
  source     = "../modules/azurerm_network_security_group"
  nsg_name   = "mim-frontend-nsg"
  location   = "West Europe"
  rg_name    = "mim-resource-group"
  nic_name = "mim-frontend-nic"
}

module "backend_nsg" {
  source     = "../modules/azurerm_network_security_group"
  nsg_name   = "mim-backend-nsg"
  location   = "West Europe"
  rg_name    = "mim-resource-group"
  nic_name = "mim-backend-nic"
}
