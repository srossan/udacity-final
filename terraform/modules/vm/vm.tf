resource "azurerm_network_interface" "test" {
  name                = "test-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = var.location
  resource_group_name = var.resource_group
  size                = "Standard_F1"
  
  computer_name  = "udacity-vm"
  network_interface_ids = [azurerm_network_interface.test.id]

  admin_username      = "stephane"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "stephane"
    public_key = file("~/.ssh/id_rsa.pub")
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
