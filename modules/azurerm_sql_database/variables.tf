variable "sql_db_name" {
  description = "The name of the SQL Database."
  type        = string
}

variable "collation" {
  description = "The collation of the SQL Database."
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "license_type" {
  description = "The license type of the SQL Database."
  type        = string
  default     = "LicenseIncluded"
}

variable "max_size_gb" {
  description = "The maximum size of the SQL Database in GB."
  type        = number
  default     = 32
}
variable "sku_name" {
  description = "The SKU name of the SQL Database."
  type        = string
  default     = "S0"
}

variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
}
variable "rg_name" {
  description = "The name of the resource group."
  type        = string
}