# Provider versioning

- Terraform version and provider version are different.
- If we do not specify a constraint , Then the latest version of provider with breaking changes might cause issues

```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}
```
When terraform init is done, .terraform.lock.hcl file is downloaded which is a dependency lock file
This adds a lock to the version. 
```
provider "registry.terraform.io/hashicorp/aws" {
  version = "6.36.0"
```
If we now update the version of provider, It will give an error
This is a very useful feature which allows us to stick to a version
```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "<= 3.10"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}

```

```
➜  terra terraform init
Initializing the backend...
Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
╷
│ Error: Failed to query available provider packages
│ 
│ Could not retrieve the list of available versions for provider hashicorp/aws:
│ locked provider registry.terraform.io/hashicorp/aws 6.36.0 does not match
│ configured version constraint <= 3.10.0; must use terraform init -upgrade to
│ allow selection of new versions
│ 
│ To see which modules are currently depending on hashicorp/aws and what
│ versions are specified, run the following command:
│     terraform providers
╵
```

- There are many ways we can speify the provider version
- >= 3.30

- <= 3.30
```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "<= 3.10"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}
```
```
➜  terra terraform init
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/aws versions matching "<= 3.10.0"...
- Installing hashicorp/aws v3.10.0...
- Installed hashicorp/aws v3.10.0 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
- ~> 5.10, any version in the 5.x range can be 5.1, 5.2, .... 5.100 
```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.10"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}

```
```
- Installed hashicorp/aws v5.100.0 (signed by HashiCorp)
```
- >=3.10,<=3.30
```
➜  terra cat main.tf 
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.20,<= 3.30"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}
```
```
➜  terra terraform init
Initializing the backend...
Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
╷
│ Error: Failed to query available provider packages
│ 
│ Could not retrieve the list of available versions for provider hashicorp/aws:
│ locked provider registry.terraform.io/hashicorp/aws 3.10.0 does not match
│ configured version constraint >= 3.20.0, <= 3.30.0; must use terraform init
│ -upgrade to allow selection of new versions
│ 
│ To see which modules are currently depending on hashicorp/aws and what
│ versions are specified, run the following command:
│     terraform providers
```
```
➜  terra terraform init -upgrade
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/aws versions matching ">= 3.20.0, <= 3.30.0"...
- Installing hashicorp/aws v3.30.0...
- Installed hashicorp/aws v3.30.0 (signed by HashiCorp)
Terraform has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
