# Configure Azure Provider
provider "azurerm" {
  features {}
}

# Create App Service Plan
resource "azurerm_service_plan" "app_plan" {
  name                = "${var.app_name}-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type            = "Linux"
  sku_name           = var.sku_name

  tags = {
    environment = var.environment
  }
}

# Create App Service
resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {}

  tags = {
    environment = var.environment
  }
}