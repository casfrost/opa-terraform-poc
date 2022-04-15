data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "role" {
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

# Service Principal is gained Contributor role on subscription level for demonstration purposes
resource "azurerm_role_assignment" "role" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_client_config.role.object_id
}

resource "azurerm_service_plan" "asp" {
  name                = var.asp_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "linux-app" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.asp.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {}
}