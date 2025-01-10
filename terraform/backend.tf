# backend.tf
terraform {
  backend "azurerm" {
    # These values will be populated by GitHub Actions
    # storage_account_name = ""
    # container_name       = ""
    # key                 = "terraform.tfstate"
    # access_key          = ""
  }
}