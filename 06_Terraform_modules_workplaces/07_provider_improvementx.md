# provider improvements


We should not use provider in modules, we should remove
modules/ec2/main.tf
```
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 5.5.0"
        }
    }
}

resource "aws_instance" "webapp" {
    ami = var.ami
    instance_type = var.instance_type
}

variable "ami" {}
variable "instance_type" {}
```

teams/A/main.tf
```
provider "aws" {
    region = "us-east-1"
}

module "ec2" {
    source = "../../modules/ec2"
    ami = "test-ami"
    instance_type = "m5.xlarge"
}
```

````
➜  A terraform plan

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.ec2.aws_instance.webapp will be created
  + resource "aws_instance" "webapp" {
      + ami                                  = "test-ami"
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
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_group_id                   = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + region                               = "us-east-1"
```
