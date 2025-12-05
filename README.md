# terraform-modules

This repository contains reusable Terraform modules for Azure resources.

## File Structure

```
terraform-modules/
├── .github/
│   └── workflows/
│       └── terraform-module-releaser.yml
├── modules/
│   └── <module_name>/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── versions.tf
│       └── tests/              # Optional test directory
│           ├── main.tf
│           ├── variables.tf
│           ├── outputs.tf
│           ├── providers.tf
│           ├── versions.tf
│           └── terraform.tfvars
├── .gitignore
├── LICENSE
└── README.md
```

Each module should be self-contained with:
- `main.tf` - Resource definitions
- `variables.tf` - Input variables
- `outputs.tf` - Output values
- `versions.tf` - Provider and Terraform version constraints
- `tests/` - Optional test directory (excluded from releases)

## Tagged Versions

When a module is tagged (e.g., `modules/az_storage_account/v1.0.0`), the `techpivot/terraform-module-releaser@v1` action places the module's files in the root of the tag.

**Excluded from tagged releases:**
- `*terraform.tfvars` files
- `**/tests/**` directories and their contents

**Example tag structure:**
```
modules/az_storage_account/v1.0.0/
├── main.tf
├── variables.tf
├── outputs.tf
└── versions.tf
```

The `tests/` directory and `terraform.tfvars` files are not included in the release.
