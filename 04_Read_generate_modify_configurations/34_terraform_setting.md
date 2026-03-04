# Settings 

We can use settings block to sspecify required terraform version , provider version and remote backend.

# terraform version
```
$ terraform version
Terraform v1.14.6
on darwin_amd64
+ provider registry.terraform.io/hashicorp/aws v6.34.0
$ cat main.tf 
terraform {
    required_version = "1.14.7" 
}

resource "aws_iam_user" "dev-users" {
    count = 3
    name = "dev-${count.index}"
}

output "iam_arns" {
    value = aws_iam_user.dev-users[*].arn
}

output "iam_users" {
    value = aws_iam_user.dev-users[*].name
}%                                                                                
$ terraform plan   
╷
│ Error: Unsupported Terraform Core version
│ 
│   on main.tf line 2, in terraform:
│    2:     required_version = "1.14.7" 
│ 
│ This configuration does not support Terraform version 1.14.6. To proceed,
│ either choose another supported Terraform version or update this version
│ constraint. Version constraints are normally set for good reason, so updating
│ the constraint may lead to other errors or unexpected behavior.
```

```
$ cat main.tf
terraform {
    required_version = "1.14.6" 
}

resource "aws_iam_user" "dev-users" {
    count = 3
    name = "dev-${count.index}"
}

output "iam_arns" {
    value = aws_iam_user.dev-users[*].arn
}

output "iam_users" {
    value = aws_iam_user.dev-users[*].name
}

$ terraform plan
aws_iam_user.dev-users[2]: Refreshing state... [id=dev-2]
aws_iam_user.dev-users[1]: Refreshing state... [id=dev-1]
aws_iam_user.dev-users[0]: Refreshing state... [id=dev-0]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.
```

# Providers
```
$ cat main.tf
terraform {
    required_version = "1.14.6" 
    required_providers {
        aws = {
            version = "6.34.0"
            source = "hashicorp/aws"
        }
    }

}

resource "aws_iam_user" "dev-users" {
    count = 3
    name = "dev-${count.index}"
}

output "iam_arns" {
    value = aws_iam_user.dev-users[*].arn
}

output "iam_users" {
    value = aws_iam_user.dev-users[*].name
}%                                                                                
$ 
$ terraform plan
aws_iam_user.dev-users[1]: Refreshing state... [id=dev-1]
aws_iam_user.dev-users[0]: Refreshing state... [id=dev-0]
aws_iam_user.dev-users[2]: Refreshing state... [id=dev-2]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.
$ 
```

```
$ cat main.tf
terraform {
    required_version = "1.14.6" 
    required_providers {
        aws = {
            version = ">6.34.0"
            source = "hashicorp/aws"
        }
    }

}

resource "aws_iam_user" "dev-users" {
    count = 3
    name = "dev-${count.index}"
}

output "iam_arns" {
    value = aws_iam_user.dev-users[*].arn
}

output "iam_users" {
    value = aws_iam_user.dev-users[*].name
}

$ terraform init
Initializing the backend...
Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
╷
│ Error: Failed to query available provider packages
│ 
│ Could not retrieve the list of available versions for provider hashicorp/aws:
│ locked provider registry.terraform.io/hashicorp/aws 6.34.0 does not match
│ configured version constraint > 6.34.0; must use terraform init -upgrade to
│ allow selection of new versions
│ 
│ To see which modules are currently depending on hashicorp/aws and what versions
│ are specified, run the following command:
│     terraform providers
╵
```
