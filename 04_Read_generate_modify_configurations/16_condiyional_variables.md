# Conditional expressions

We can select instance type based on the environment, Whether the environment is dev or production using conditional variables

```$ cat main.tf 
variable "env" {
  default = "dev"
}

resource "aws_instance" "server" {
  ami = "ami-123"
  instance_type = if var.env == "dev" ? "t2.micro" : "m5.xlarge"
}%   
```

```
variable "env" {
  default = "prod"
}

resource "aws_instance" "server" {
  ami = "ami-123"
  instance_type = var.env == "dev" ? "t2.micro" : "m5.xlarge"
}

  + resource "aws_instance" "server" {
      + ami                                  = "ami-123"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
```


```
  + resource "aws_instance" "server" {
      + ami                                  = "ami-123"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "m5.xlarge"
```


```
$ cat main.tf 
variable "env" {
  default = "prod"
}

resource "aws_instance" "server" {
  ami = "ami-123"
  instance_type = var.env != "dev" ? "t2.micro" : "m5.xlarge"
}%                                                                                 
$ 
```

```

  # aws_instance.server will be created
  + resource "aws_instance" "server" {
      + ami                                  = "ami-123"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
```


```
$ cat main.tf
variable "env" {
  default = "prod"
}

variable "region" {
  default = "us-east-1"
}

resource "aws_instance" "server" {
  ami = "ami-123"
  instance_type = var.env == "prod" && var.region == "us-east-1" ? "m5.xlarge" : "t3.micro"
}%                                                                                 
$ terraform plan

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.server will be created
  + resource "aws_instance" "server" {
      + ami                                  = "ami-123"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "m5.xlarge"
```



```
$ cat main.tf   
variable "env" {
  default = "dev"
}

variable "region" {
  default = "us-east-1"
}

resource "aws_instance" "server" {
  ami = "ami-123"
  instance_type = var.env == "prod" && var.region == "us-east-1" ? "m5.xlarge" : "t3.micro"
}%                                                                                 
$ terraform plan

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.server will be created
  + resource "aws_instance" "server" {
      + ami                                  = "ami-123"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
```
