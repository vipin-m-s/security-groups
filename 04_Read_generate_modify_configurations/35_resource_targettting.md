# Resource targetting

We can specify only the resources we want to plan, apply, destory using resource targetting. 
Suppose there are many resources such as ec2 instance, security group and iam user in main.tf file and we want to plan, apply and destory only the iam user. 
We should target it in terraform command using -target="aws_iam_user.dev_1"

```
$ cat main.tf 
resource "aws_instance" "app" {
    ami = "ami-123"
    instance_type = "t3.micro"
}

resource "aws_security_group" "sg" {
    name = "sg"
}

resource "aws_iam_user" "dev_1" {
    name = "dev_1"
}
```
```
$ terraform plan
aws_iam_user.dev-users[2]: Refreshing state... [id=dev-2]
aws_iam_user.dev-users[1]: Refreshing state... [id=dev-1]
aws_iam_user.dev-users[0]: Refreshing state... [id=dev-0]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create
  - destroy

Terraform will perform the following actions:

  # aws_iam_user.dev-users[0] will be destroyed
  # (because aws_iam_user.dev-users is not in configuration)
  - resource "aws_iam_user" "dev-users" {
      - arn                  = "arn:aws:iam::707264480025:user/dev-0" -> null
      - force_destroy        = false -> null
      - id                   = "dev-0" -> null
      - name                 = "dev-0" -> null
      - path                 = "/" -> null
      - tags                 = {} -> null
      - tags_all             = {} -> null
      - unique_id            = "AIDA2JLB7QMM6PH46VYL2" -> null
        # (1 unchanged attribute hidden)
    }

  # aws_iam_user.dev-users[1] will be destroyed
  # (because aws_iam_user.dev-users is not in configuration)
  - resource "aws_iam_user" "dev-users" {
      - arn                  = "arn:aws:iam::707264480025:user/dev-1" -> null
      - force_destroy        = false -> null
      - id                   = "dev-1" -> null
      - name                 = "dev-1" -> null
      - path                 = "/" -> null
      - tags                 = {} -> null
      - tags_all             = {} -> null
      - unique_id            = "AIDA2JLB7QMM4YS6FDLW5" -> null
        # (1 unchanged attribute hidden)
    }

  # aws_iam_user.dev-users[2] will be destroyed
  # (because aws_iam_user.dev-users is not in configuration)
  - resource "aws_iam_user" "dev-users" {
      - arn                  = "arn:aws:iam::707264480025:user/dev-2" -> null
      - force_destroy        = false -> null
      - id                   = "dev-2" -> null
      - name                 = "dev-2" -> null
      - path                 = "/" -> null
      - tags                 = {} -> null
      - tags_all             = {} -> null
      - unique_id            = "AIDA2JLB7QMM2H65TLA76" -> null
        # (1 unchanged attribute hidden)
    }

  # aws_iam_user.dev_1 will be created
  + resource "aws_iam_user" "dev_1" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "dev_1"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_instance.app will be created
```

# target
```
$ terraform plan -target="aws_iam_user.dev_1"

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.dev_1 will be created
  + resource "aws_iam_user" "dev_1" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "dev_1"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
╷
│ Warning: Resource targeting is in effect
│ 
│ You are creating a plan with the -target option, which means that the result of
│ this plan may not represent all of the changes requested by the current
│ configuration.
│ 
│ The -target option is not for routine use, and is provided only for exceptional
│ situations such as recovering from errors or mistakes, or when Terraform
│ specifically suggests to use it as part of an error message.
╵

─────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
$ 
```
