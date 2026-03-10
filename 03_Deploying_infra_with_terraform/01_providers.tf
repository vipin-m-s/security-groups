# Providers

## 1. provider plugins
- When we specify the provider block in .tf files
- The provider plugins are downloaded to .terraform folder.
- When  we add new providers we should always runs terraform init
- Terraform init will download the provider plugin in the .terraform folder

```
provider "aws" {}
```

## 2. Resource  
- We should create resource as per the provider.
- We can create aws_instance using azurerm provider
- We can use multiple provider within the same .tf file

# Provider tiers

Official - owned and maintained by hashicorp
Partner - owned and maintained by technology company
Community - owned and maintained by individual contributor

# Provider namespace

official - hashicorp
Partner - third party digitalocean/digitalocean
Community - Maintainers individual

# required_providers 
- For any Not hashicorp maintained provider such as partner or community providers
- We should use the terraform setting of required_providers
- Without which there will be errors during init/plan/apply.
- For hashicorp maintained we need not add required_providers block
```
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}
```

