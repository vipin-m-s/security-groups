# Saving plan to files

we can save the terraform plan to a file and then apply the plan using terraform apply.
This is used in production to ensure that what is present in plan is what is being applied.
Binary file is stored and it is not a text fiel being stored

# Plan 
The plan would be outputted to screeen as usual and also a infra.plan binary would be stored

  ```
$ terraform plan -out=infra.plan

$ terraform plan -out=infra.plan
aws_iam_user.dev-users[0]: Refreshing state... [id=dev-user-0]
aws_iam_user.dev-users[2]: Refreshing state... [id=dev-user-2]
aws_iam_user.dev-users[1]: Refreshing state... [id=dev-user-1]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create
  - destroy

Terraform will perform the following actions:

  # aws_iam_user.dev-users[0] will be destroyed
  # (because aws_iam_user.dev-users is not in configuration)
  - resource "aws_iam_user" "dev-users" {
      - arn                  = "arn:aws:iam::707264480025:user/dev-user-0" -> null
      - force_destroy        = false -> null
      - id                   = "dev-user-0" -> null
      - name                 = "dev-user-0" -> null
      - path                 = "/" -> null
      - tags                 = {} -> null
      - tags_all             = {} -> null
      - unique_id            = "AIDA2JLB7QMMWIK6WCAL6" -> null
        # (1 unchanged attribute hidden)
    }

  # aws_iam_user.dev-users[1] will be destroyed
  # (because aws_iam_user.dev-users is not in configuration)
  - resource "aws_iam_user" "dev-users" {
      - arn                  = "arn:aws:iam::707264480025:user/dev-user-1" -> null
      - force_destroy        = false -> null
      - id                   = "dev-user-1" -> null
      - name                 = "dev-user-1" -> null
      - path                 = "/" -> null
      - tags                 = {} -> null
      - tags_all             = {} -> null
      - unique_id            = "AIDA2JLB7QMMQUZZNMQXO" -> null
        # (1 unchanged attribute hidden)
    }

  # aws_iam_user.dev-users[2] will be destroyed
  # (because aws_iam_user.dev-users is not in configuration)
  - resource "aws_iam_user" "dev-users" {
      - arn                  = "arn:aws:iam::707264480025:user/dev-user-2" -> null
      - force_destroy        = false -> null
      - id                   = "dev-user-2" -> null
      - name                 = "dev-user-2" -> null
      - path                 = "/" -> null
      - tags                 = {} -> null
      - tags_all             = {} -> null
      - unique_id            = "AIDA2JLB7QMMW66DY36EO" -> null
        # (1 unchanged attribute hidden)
    }

  # aws_instance.webserver1 will be created
  + resource "aws_instance" "webserver1" {
      + ami                                  = "ami-090b9c8aa1c84aefc"
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
      + region                               = "ap-south-2"
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags_all                             = (known after apply)
      + tenancy                              = (known after apply)
      + user_data                            = <<-EOT
            #!/bin/bash 
            python -m http.server 80
        EOT
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + primary_network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)

      + secondary_network_interface (known after apply)
    }

  # aws_instance.webserver2 will be created
  + resource "aws_instance" "webserver2" {
      + ami                                  = "ami-090b9c8aa1c84aefc"
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
      + region                               = "ap-south-
```

# Apply
We can directly apply the plan using terraform apply
```
$ terraform apply infra.plan    
aws_iam_user.dev-users[0]: Destroying... [id=dev-user-0]
aws_iam_user.dev-users[1]: Destroying... [id=dev-user-1]
aws_iam_user.dev-users[2]: Destroying... [id=dev-user-2]
aws_vpc.vpc: Creating...
aws_s3_bucket.s3: Creating...
aws_iam_user.dev-users[1]: Destruction complete after 1s
aws_iam_user.dev-users[0]: Destruction complete after 1s
aws_iam_user.dev-users[2]: Destruction complete after 1s
aws_vpc.vpc: Creation complete after 1s [id=vpc-0b9eabf74914e3a5f]
aws_internet_gateway.igw: Creating...
aws_subnet.subnet1: Creating...
aws_subnet.subnet2: Creating...
aws_security_group.webapp_sg: Creating...
aws_lb_target_group.webapp-tg: Creating...
aws_s3_bucket.s3: Creation complete after 2s [id=vipin-m-s-terraform]
aws_internet_gateway.igw: Creation complete after 1s [id=igw-0f60670f55c24aca2]
aws_route_table.rt: Creating...
aws_lb_target_group.webapp-tg: Creation complete after 1s [id=arn:aws:elasticloadbalancing:ap-south-2:707264480025:targetgroup/webapp-tg/c6e37e151c37ef4e]
aws_route_table.rt: Creation complete after 1s [id=rtb-05ba8ecc934d15501]
aws_security_group.webapp_sg: Creation complete after 3s [id=sg-02fa44097b6c2cb3f]
aws_subnet.subnet1: Still creating... [00m10s elapsed]
aws_subnet.subnet2: Still creating... [00m10s elapsed]
aws_subnet.subnet1: Creation complete after 12s [id=subne
```


