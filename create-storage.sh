#!/usr/bin/env bash
set -euo pipefail

# Creates resource group, storage account, blob container and assigns
# 'Storage Blob Data Contributor' to a service principal object id.
# Ensure that this resource group is separate from any other environments in (e.g. production, dev, uat) to avoid accidental deletion of shared resources.

# Usage example:
# SUBSCRIPTION_ID=00000000-0000-0000-0000-000000000000 ./create-storage.sh

SUBSCRIPTION_ID="${SUBSCRIPTION_ID:-}"
RESOURCE_GROUP="${RESOURCE_GROUP:-oidc-backend-rg}"
LOCATION="${LOCATION:-uksouth}"
STORAGE_ACCOUNT="${STORAGE_ACCOUNT:-oidcterraformstorage}"
CONTAINER_NAME="${CONTAINER_NAME:-oidc-production-tfstate-container}"
SP_OBJECT_ID="${SP_OBJECT_ID:-b6eadcb0-6e9a-45e3-9dc1-7836df1cd82f}"

if [ -z "$SUBSCRIPTION_ID" ]; then
  echo "No SUBSCRIPTION_ID provided, using current account subscription..."
  SUBSCRIPTION_ID=$(az account show --query id -o tsv) || { echo "Failed to get subscription id. Run 'az login' or set SUBSCRIPTION_ID."; exit 1; }
fi

echo "Using subscription: $SUBSCRIPTION_ID"
az account set --subscription "$SUBSCRIPTION_ID"

echo "Creating resource group '$RESOURCE_GROUP' in '$LOCATION' (idempotent)..."
az group create --name "$RESOURCE_GROUP" --location "$LOCATION" --output none

echo "Creating storage account '$STORAGE_ACCOUNT' (idempotent)..."
az storage account create \
  --name "$STORAGE_ACCOUNT" \
  --resource-group "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  --sku Standard_LRS \
  --kind StorageV2 \
  --output none

sleep 5 # Wait a moment for the container to be fully provisioned

echo "Creating blob container '$CONTAINER_NAME' (using Entra ID auth)..."
az storage container create \
  --name "$CONTAINER_NAME" \
  --account-name "$STORAGE_ACCOUNT" \
  --auth-mode login \
  --output none

SCOPE="/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Storage/storageAccounts/$STORAGE_ACCOUNT"

echo "Assigning 'Storage Blob Data Contributor' to object id $SP_OBJECT_ID at scope $SCOPE..."
MSYS_NO_PATHCONV=1 az role assignment create \
  --assignee-object-id "$SP_OBJECT_ID" \
  --assignee-principal-type ServicePrincipal \
  --role "Storage Blob Data Contributor" \
  --scope "$SCOPE" \
  --output none || echo "Role assignment may already exist or failed."

echo "Done. Storage account: $STORAGE_ACCOUNT, container: $CONTAINER_NAME, role assigned to $SP_OBJECT_ID"