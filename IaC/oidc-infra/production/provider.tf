provider "azurerm" {
  # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
  subscription_id = var.ARM_SUBSCRIPTION_ID
}

terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.42.0"
    }
  }
}