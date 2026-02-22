terraform {
  backend "azurerm" {
    resource_group_name = "oidc"
    storage_account_name = "oidcterraformstorage"
    container_name = "oidc-production-tfstate-container"
    key = "production.tfstate"
    use_azuread_auth     = true
  }
}