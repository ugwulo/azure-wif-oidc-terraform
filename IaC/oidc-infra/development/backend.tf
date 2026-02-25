terraform {
  backend "azurerm" {
    resource_group_name = "oidc-backend-rg"
    storage_account_name = "oidcterraformstorage"
    container_name = "oidc-development-tfstate-container"
    key = "development.tfstate"
    use_azuread_auth     = true
  }
}