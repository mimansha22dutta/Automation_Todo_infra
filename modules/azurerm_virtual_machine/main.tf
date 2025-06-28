resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    public_ip_address_id          = data.azurerm_public_ip.pip.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.size
  admin_username      = data.azurerm_key_vault_secret.username.value
  admin_password      = data.azurerm_key_vault_secret.password.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }

 provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type     = "ssh"
      user     = data.azurerm_key_vault_secret.username.value
      password = data.azurerm_key_vault_secret.password.value
      host     = data.azurerm_public_ip.pip.ip_address
    }
  }

#  Custom Data Method to install nginx on VM
  #   custom_data = base64encode(<<-EOF
  #   #!/bin/bash
  #   apt-get update -y
  #   apt-get install -y nginx
  #   systemctl enable nginx
  #   systemctl start nginx
  # EOF
  # )
}