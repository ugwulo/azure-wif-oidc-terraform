provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
    # The provider will be authenticated by the OIDC token
    # from the GitHub Actions workflow.
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