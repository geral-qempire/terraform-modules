# Azure RBAC Profile Assignment Module

This module assigns multiple Azure RBAC roles to multiple principals by looking up principals by name/type and creating role assignments across one or more scopes. It creates a cartesian product of all roles × all principals × all scopes, assigning each role to each principal for every provided scope.

## Features

- **Principal Lookup by Name**: Automatically looks up Azure AD Users, Groups, and Service Principals by display name
- **Managed Identity Support**: Supports Managed Identities using resource ID
- **Multiple Roles**: Assign multiple roles to multiple principals in a single module call
- **Multiple Scopes**: Apply the same role set to every principal across several scopes at once
- **Auto-detection**: Principal types are auto-detected by Azure when possible

## Usage

### Basic Example - Single Principal Type

```hcl
module "rbac_profile" {
  source = "../az_rbac_profile_assignment"

  roles = [
    "Reader",
    "Storage Blob Data Contributor"
  ]

  principals = [
    {
      name = "My Service Principal"
      type = "ServicePrincipal"
    }
  ]

  scopes = [
    azurerm_storage_account.example.id,
    azurerm_resource_group.extra.id
  ]
}
```

### Multiple Principals - Mixed Types

```hcl
module "rbac_profile" {
  source = "../az_rbac_profile_assignment"

  roles = [
    "Reader",
    "Storage Blob Data Contributor",
    "Storage Blob Data Reader"
  ]

  principals = [
    {
      name = "john.doe@example.com"
      type = "User"
    },
    {
      name = "Developers Group"
      type = "Group"
    },
    {
      name = "my-app-service-principal"
      type = "ServicePrincipal"
    },
    {
      name = "/subscriptions/.../resourceGroups/.../providers/Microsoft.ManagedIdentity/userAssignedIdentities/my-identity"
      type = "ManagedIdentity"
    }
  ]

  scope = azurerm_storage_account.example.id
}
```

### With Service Principal AAD Check

```hcl
module "rbac_profile" {
  source = "../az_rbac_profile_assignment"

  roles = ["Reader"]

  principals = [
    {
      name = "My Service Principal"
      type = "ServicePrincipal"
    }
  ]

  scope                            = azurerm_resource_group.example.id
  skip_service_principal_aad_check = false
}
```

## Inputs

| Name | Type | Default | Required | Description |
|------|------|---------|:--------:|-------------|
| `roles` | `list(string)` | n/a | yes | List of role definition names to assign (e.g., 'Storage Blob Data Contributor') |
| `principals` | `list(object({ name = string, type = string }))` | `[]` | yes | List of principal objects. Each object must have:<br>- `name` (string): Display name for Users/Groups/ServicePrincipals, or resource ID for Managed Identities<br>- `type` (string): Principal type - "User", "Group", "ServicePrincipal", or "ManagedIdentity" |
| `scope` | `string` | `null` | no | (Deprecated in favour of `scopes`.) Single Azure resource ID where roles will be assigned. Use when you only have one scope. |
| `scopes` | `list(string)` | `[]` | no | List of Azure resource IDs where roles will be assigned. Provide one or more scopes to grant every role to every principal for each scope. |
| `skip_service_principal_aad_check` | `bool` | `true` | no | If set to true, skips the Azure Active Directory check for service principals in the tenant |

### Principal Types

- **User**: Azure AD User looked up by `display_name`
- **Group**: Azure AD Group looked up by `display_name`
- **ServicePrincipal**: Azure AD Service Principal looked up by `display_name`
- **ManagedIdentity**: User Assigned Managed Identity identified by full resource ID

## Outputs

| Name | Description |
|------|-------------|
| `role_assignment_ids` | Map of role assignment resource IDs keyed by the assignment key |

## How It Works

1. **Principal Lookup**: The module uses Azure AD data sources to look up principals:
   - `azuread_user` for Users (by display_name)
   - `azuread_group` for Groups (by display_name)
   - `azuread_service_principal` for Service Principals (by display_name)
   - `azurerm_user_assigned_identity` for Managed Identities (by resource_id)

2. **Cartesian Product**: Creates all combinations of roles × principals

3. **Role Assignment**: Uses the `az_role_assignment` module to create the actual role assignments

## Requirements

- Terraform `>= 1.12.1, < 2.0.0`
- AzureRM provider `~> 4.38`
- AzureAD provider `~> 2.0` (for principal lookup)

## Notes

- Principal lookup by display_name may return multiple results if duplicates exist. The module will use the first match found.
- For Managed Identities, provide the full Azure resource ID (not just the name).
- The `principal_type` is intentionally omitted from role assignments to allow Azure to auto-detect the type when possible.
- If you need more control over principal type detection, you may need to use the underlying `az_role_assignment` module directly.

## Examples by Principal Type

### Azure AD User

```hcl
principals = [
  {
    name = "john.doe@example.com"
    type = "User"
  }
]
```

### Azure AD Group

```hcl
principals = [
  {
    name = "Developers"
    type = "Group"
  }
]
```

### Service Principal

```hcl
principals = [
  {
    name = "my-app-sp"
    type = "ServicePrincipal"
  }
]
```

### Managed Identity

```hcl
principals = [
  {
    name = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/my-identity"
    type = "ManagedIdentity"
  }
]
```

