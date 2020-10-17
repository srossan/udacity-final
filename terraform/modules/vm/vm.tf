resource "azurerm_network_interface" "test" {
  name                = ""
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id_test
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}-vm"
  location            = var.location
  resource_group_name = var.resource_group
  size                = "100"
  admin_username      = "admin"
  network_interface_ids = []
  admin_ssh_key {
    username   = "admin"
    public_key = "file("~/.ssh/id_rsa.pub")"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
