#!/bin/bash
set -e

KV_NAME="$1"
RG_NAME="$2"
LOCATION="$3"

source "$(dirname "$0")/utils.sh"

if [[ -z "$KV_NAME" || -z "$RG_NAME" || -z "$LOCATION" ]]; then
  error "Usage: ./create-kv.sh <kv-name> <resource-group> <location>"
fi

log "Checking if Resource Group $RG_NAME exists..."
if [ "$(az group exists --name "$RG_NAME")" = "false" ]; then
  error "Resource Group $RG_NAME does not exist. Create it before creating Key Vault."
fi

log "Checking if Key Vault $KV_NAME already exists..."
if az keyvault show --name "$KV_NAME" --resource-group "$RG_NAME" >/dev/null 2>&1; then
  log "Key Vault $KV_NAME already exists. Skipping creation."
  exit 0
fi

log "Creating Key Vault: $KV_NAME in $RG_NAME ($LOCATION)"

az keyvault create \
  --name "$KV_NAME" \
  --resource-group "$RG_NAME" \
  --location "$LOCATION" \
  --sku standard

log "Key Vault created successfully."
