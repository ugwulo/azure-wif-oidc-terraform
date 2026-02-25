terraform {
  backend "azurerm" {
    resource_group_name = "oidc-backend-rg"
    storage_account_name = "oidcterraformstorage"
    container_name = "oidc-uat-tfstate-container"
    key = "uat.tfstate"
    use_azuread_auth     = true
  }
}