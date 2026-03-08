# mutliple providers

- Suppose we want to create 1 resource in mumbai region and other resource in 
north virginia region. 
- by default this will create resource in us-east-1 region
```
$ cat main.tf
provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "dev" {
  name = "dev"
}

resource "aws_security_group" "prod" {
  name = "prod"
}
```
```
$ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_security_group.dev will be created
  + resource "aws_security_group" "dev" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "dev"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "us-east-1"
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.prod will be created
  + resource "aws_security_group" "prod" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "prod"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "us-east-1"
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.
```

- We need to add providers with aliases
- just by adding provider with alias it will not automatically deploy in those regions
- We need to include provider in the resource block

```
$ cat main.tf
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias = "mumbai"
  region = "ap-south-1"
}

provider "aws" {
  alias = "hyderabad"
  region = "ap-south-2"
}

resource "aws_security_group" "dev" {
  provider = aws.mumbai
  name = "dev"
}

resource "aws_security_group" "prod" {
  provider = aws.hyderabad
  name = "prod"
}
```

```
  # aws_security_group.dev will be created
  + resource "aws_security_group" "dev" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "dev"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "ap-south-1"
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.prod will be created
  + resource "aws_security_group" "prod" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "prod"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "ap-south-2"
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }
```
