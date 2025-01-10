# Configure Azure Provider
provider "azurerm" {
  features {}
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    environment = var.environment
  }
}

# Create App Service Plan
resource "azurerm_service_plan" "app_plan" {
  name                = "${var.app_name}-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type            = "Linux"
  sku_name           = var.sku_name

  tags = {
    environment = var.environment
  }
}

# Create App Service
resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    application_stack {
      docker_image_name     = "${var.docker_username}/${var.app_name}/latest"
    }
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_REGISTRY_SERVER_URL"          = "https://index.docker.io"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = var.docker_username
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = var.docker_password
  }

  tags = {
    environment = var.environment
  }
}