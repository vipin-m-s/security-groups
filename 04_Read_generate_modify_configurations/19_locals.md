# Locals 


When we want to use some advanced methods to create a name we cannot use variables, so we can use locals in that case
Locals can only be defined in main configuration files. Cannot be used in *.tfvars, TF_VAR_ etc. Whereas variables can be used


```
resource "aws_security_group" "app_firewall" {
  name = "app_firewall"
  tags = {
    Team = "Payments"
    CreationDate = formatdate("DD MM YYYY", timestamp())
  }
}

resource "aws_security_group" "db_firewall" {
  name = "db_firewall"
  tags = {
    Team = "Payments"
    CreationDate = formatdate("DD MM YYYY", timestamp())
  }
}
```
<img width="1609" height="458" alt="Screenshot 2026-03-02 at 3 05 22 PM" src="https://github.com/user-attachments/assets/5fec1730-9f60-42f9-abce-6b6ce52a2221" />

```
➜  terraform terraform apply -auto-approve  


Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_security_group.app_firewall will be created
  + resource "aws_security_group" "app_firewall" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "app_firewall"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "ap-south-2"
      + revoke_rules_on_delete = false
      + tags                   = (known after apply)
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.db_firewall will be created
  + resource "aws_security_group" "db_firewall" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "db_firewall"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "ap-south-2"
      + revoke_rules_on_delete = false
      + tags                   = (known after apply)
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.
aws_security_group.db_firewall: Creating...
aws_security_group.app_firewall: Creating...
aws_security_group.db_firewall: Creation complete after 3s [id=sg-096ba386848111fcb]
aws_security_group.app_firewall: Creation complete after 3s [id=sg-0f84be20565e6aa2d]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

# There is lot of repition in tags, We do not want to repeat it in all the blocks. We can create variables for tags. 

```
➜  terraform cat main.tf 
variable "payment_team_tags" {
  type = map 
  default = {
    Team = "Payments"
    CreationDate = formatdate("DD MM YYYY", timestamp())
  }
}

resource "aws_security_group" "app_firewall" {
  name = "app_firewall"
  tags = var.payment_team_tags
}

resource "aws_security_group" "db_firewall" {
  name = "db_firewall"
  tags = var.payment_team_tags
}
```

       `                                                                               
We cannot use functions in variable!!!!!
```
$ terraform terraform plan
╷
│ Error: Function calls not allowed
│ 
│   on main.tf line 5, in variable "payment_team_tags":
│    5:     CreationDate = formatdate("DD MM YYYY", timestamp())
│ 
│ Functions may not be called here.
╵
➜  terraform 

```

# Use locals for using functions 

```
$ cat main.tf                    
locals {
  payment_team_tags = {
    Team = "Payments"
    CreationDate = formatdate("DD MM YYYY", timestamp())
  }
}

resource "aws_security_group" "app_firewall" {
  name = "app_firewall"
  tags = local.payment_team_tags
}

resource "aws_security_group" "db_firewall" {
  name = "db_firewall"
  tags = local.payment_team_tags
}
```
```                                                                                      
$ terraform apply -auto-approve  

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_security_group.app_firewall will be created
  + resource "aws_security_group" "app_firewall" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "app_firewall"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "ap-south-2"
      + revoke_rules_on_delete = false
      + tags                   = (known after apply)
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.db_firewall will be created
  + resource "aws_security_group" "db_firewall" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "db_firewall"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "ap-south-2"
      + revoke_rules_on_delete = false
      + tags                   = (known after apply)
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.
aws_security_group.db_firewall: Creating...
aws_security_group.app_firewall: Creating...
aws_security_group.db_firewall: Creation complete after 2s [id=sg-06a434b69ed3a3be0]
aws_security_group.app_firewall: Creation complete after 2s [id=sg-016eb4216bca161fe]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```
<img width="1619" height="655" alt="Screenshot 2026-03-02 at 3 09 38 PM" src="https://github.com/user-attachments/assets/c77ea67d-1bd4-40b2-8a7f-e05611a9f361" />


