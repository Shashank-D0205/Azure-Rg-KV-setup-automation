# Azure Resource Group & Key Vault Setup

This repository contains a GitHub Actions workflow to automate:

- Creating or updating Azure Resource Groups  
- Creating Azure Key Vaults  
- Validating inputs (RG existence, KV existence)  
- Secure authentication using GitHub Secrets  

## How to Use

Trigger the workflow manually:

1. Go to **Actions → azure-rg-kv-setup**
2. Click **Run Workflow**
3. Provide:
   - Environment
   - Resource group details
   - Key Vault details
   - Flags whether to create RG/KV

## Secrets Required

| Secret | Description |
|--------|-------------|
| `AZURE_CLIENT_ID` | Azure Service Principal |
| `AZURE_CLIENT_SECRET` | SP password |
| `AZURE_SUBSCRIPTION_ID` | Subscription |
| `AZURE_TENANT_ID` | Azure Tenant |

## Folder Structure

```
azure-rg-kv-setup/
  ├── .github/workflows/azure-rg-kv-setup.yaml
  ├── scripts/
  └── README.md
```

## Purpose

This automation is useful for provisioning cloud resources for:

- App on-boarding  
- Environment creation  
- CI/CD bootstrap  
- Secret management  

## Architecture Diagram

```
         ┌─────────────────────────────┐
         │      GitHub Actions         │
         │  azure-rg-kv-setup.yaml     │
         └──────────────┬──────────────┘
                        │
     ┌──────────────────┴───────────────────┐
     │                                      │
┌────▼────┐                           ┌────▼────┐
│  Step 1 │                           │  Step 2 │
│  Login  │                           │ Create/ │
│ to Azure│                           │ Update  │
│ (SPN)   │                           │   RG    │
└────┬────┘                           └────┬────┘
     │                                      │
     │                                      │
     │                              (Optional)
     │                                      │
     │                                      ▼
     │                               ┌──────────┐
     │                               │  Azure   │
     │                               │Resource  │
     │                               │  Group   │
     │                               └────┬─────┘
     │                                      │
     │                                      │
     │                             (If RG exists)
     │                                      │
     ▼                                      ▼
┌──────────┐                         ┌─────────────┐
│  Step 3  │                         │   Step 4    │
│ Create   │                         │  Create KV  │
│  KeyVault│                         │ (Idempotent)│
└────┬─────┘                         └──────┬──────┘
     │                                         │
     │                                         ▼
     │                               ┌────────────────┐
     │                               │ Azure KeyVault │
     │                               │ (Secret Store) │
     │                               └────────────────┘
     │
     ▼
┌───────────────┐
│  Outputs:     │
│ - RG created  │
│ - KV created  │
│ - Safe re-run │
└───────────────┘
```
