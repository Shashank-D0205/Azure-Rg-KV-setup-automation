#!/bin/bash
set -e


RG_NAME="$1"
LOCATION="$2"

source "$(dirname "$0")/utils.sh"

if [[ -z "$RG_NAME" || -z "$LOCATION" ]]; then
  error "Usage: ./create-rg.sh <resource-group-name> <location>"
fi

log "Creating or updating Resource Group: $RG_NAME in $LOCATION"

az group create --name "$RG_NAME" --location "$LOCATION"

log "Resource Group operation completed."
