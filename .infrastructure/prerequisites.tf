resource "azurerm_resource_group" "rg" {
    name = "opa-poc-rg"
    location = var.resource_group_location
}

