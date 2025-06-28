variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group where the SQL Server will be created."
  type        = string
}
variable "location" {
  description = "The Azure location where the SQL Server will be created."
  type        = string
}
# variable "version" {
#   description = "The version of the SQL Server."
#   type        = string
#   default     = "12.0"
# }

variable "key_vault_name" {
  description = "The name of the Key Vault where the SQL Server credentials will be stored."
  type        = string
}

variable "sql_admin_username_secret_name" {
  description = "value of the secret in Key Vault that contains the SQL Server administrator username."
  type       = string
}

variable "sql_admin_password_secret_name" {
  description = "value of the secret in Key Vault that contains the SQL Server administrator password."
  type        = string
}