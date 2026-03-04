# LifeCycle Meta

We can use lifecycle meta to change the defualt behaviour

# Create Before Destory

When we update some of the things of an resource, The resource cannot be changed in place. 
The resource needs to be destroyed and recreated. The current behaviour is
1) Destroy the resource
2) Recreate the resource

```

$ cat main.tf 
data "aws_ami" "latest_ubuntu_image" {
    owners = ["amazon"]
    most_recent = true

    filter {
        name = "name"
        values = ["*ubuntu*"]
    }
}

resource "aws_instance" "app" {
    ami = data.aws_ami.latest_ubuntu_image.image_id
    instance_type = "t3.micro"
}%



$ terraform apply -auto-approve
data.aws_ami.latest_ubuntu_image: Reading...
data.aws_ami.latest_ubuntu_image: Read complete after 1s [id=ami-0f748860f1621ec05]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.app will be created
  + resource "aws_instance" "app" {
      + ami                                  = "ami-0f748860f1621ec05"
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

If we want to change the OS now. Then it is not possible to update in place. The older instance should be deleted. 
New instance with new OS should be started

Basically in production environments, We do not want the resource to be destoryed.
We want to create a resource first and then destory the older resource.
to maintain availability

```
data "aws_ami" "latest_ubuntu_image" {
    owners = ["amazon"]
    most_recent = true

    filter {
        name = "name"
        values = ["*al*"]
    }
}

resource "aws_instance" "app" {
    ami = data.aws_ami.latest_ubuntu_image.image_id
    instance_type = "t3.micro"
}




$ terraform plan
data.aws_ami.latest_ubuntu_image: Reading...
data.aws_ami.latest_ubuntu_image: Read complete after 4s [id=ami-0035bcd3cad6883a6]
aws_instance.app: Refreshing state... [id=i-04eefeb3f8cc97176]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_instance.app must be replaced
-/+ resource "aws_instance" "app" {
      ~ ami                                  = "ami-0f748860f1621ec05" -> "ami-0035bcd3cad6883a6" # forces replacement
      ~ arn                                  = "arn:aws:ec2:ap-south-2:707264480025:instance/i-04eefeb3f8cc97176" -> (known after apply)
      ~ associate_public_ip_address          = true -> (known after apply)
      ~ availability_zone                    = "ap-south-2a" -> (known after apply)
      ~ disable_api_stop                     = false -> (known after apply)
      ~ disable_api_termination              = false -> (known after apply)
      ~ ebs_optimized                        = false -> (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      - hibernation                          = false -> null
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      ~ id                                   = "i-04eefeb3f8cc97176" -> (known after apply)
      ~ instance_initiated_shutdown_behavior = "stop" -> (known after apply)
      + instance_lifecycle                   = (known after apply)
      ~ instance_state                       = "running" -> (known after apply)
      ~ ipv6_address_count                   = 0 -> (known after apply)
      ~ ipv6_addresses                       = [] -> (known after apply)
      + key_name                             = (known after apply)
      ~ monitoring                           = false -> (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_group_id                   = (known after apply)
      ~ placement_partition_number           = 0 -> (known after apply)
      ~ primary_network_interface_id         = "eni-0492e79a6305cbd21" -> (known after apply)
      ~ private_dns                          = "ip-172-31-11-136.ap-south-2.compute.internal" -> (known after apply)
      ~ private_ip                           = "172.31.11.136" -> (known after apply)
      ~ public_dns                           = "ec2-18-60-184-85.ap-south-2.compute.amazonaws.com" -> (known after apply)
      ~ public_ip                            = "18.60.184.85" -> (known after apply)
      ~ secondary_private_ips                = [] -> (known after apply)
      ~ security_groups                      = [
          - "default",
        ] -> (known after apply)
      + spot_instance_request_id             = (known after apply)
      ~ subnet_id                            = "subnet-0cfa1aa04c041aee0" -> (known after apply)
      - tags                                 = {} -> null
      ~ tags_all                             = {} -> (known after apply)
      ~ tenancy                              = "default" -> (known after apply)
      + user_data_base64                     = (known after apply)
      ~ vpc_security_group_ids               = [
          - "sg-03e4951a68d033c35",
        ] -> (known after apply)
        # (6 unchanged attributes hidden)

      ~ capacity_reservation_specification (known after apply)
      - capacity_reservation_specification {
          - capacity_reservation_preference = "open" -> null
        }

      ~ cpu_options (known after apply)
      - cpu_options {
          - core_count            = 1 -> null
          - threads_per_core      = 2 -> null
            # (2 unchanged attributes hidden)
        }

      - credit_specification {
          - cpu_credits = "unlimited" -> null
        }

      ~ ebs_block_device (known after apply)

      ~ enclave_options (known after apply)
      - enclave_options {
          - enabled = false -> null
        }

      ~ ephemeral_block_device (known after apply)

      ~ instance_market_options (known after apply)

      ~ maintenance_options (known after apply)
      - maintenance_options {
          - auto_recovery = "default" -> null
        }

      ~ metadata_options (known after apply)
      - metadata_options {
          - http_endpoint               = "enabled" -> null
          - http_protocol_ipv6          = "disabled" -> null
          - http_put_response_hop_limit = 1 -> null
          - http_tokens                 = "optional" -> null
          - instance_metadata_tags      = "disabled" -> null
        }

      ~ network_interface (known after apply)

      ~ primary_network_interface (known after apply)
      - primary_network_interface {
          - delete_on_termination = true -> null
          - network_interface_id  = "eni-0492e79a6305cbd21" -> null
        }

      ~ private_dns_name_options (known after apply)
      - private_dns_name_options {
          - enable_resource_name_dns_a_record    = false -> null
          - enable_resource_name_dns_aaaa_record = false -> null
          - hostname_type                        = "ip-name" -> null
        }

      ~ root_block_device (known after apply)
      - root_block_device {
          - delete_on_termination = true -> null
          - device_name           = "/dev/sda1" -> null
          - encrypted             = false -> null
          - iops                  = 100 -> null
          - tags                  = {} -> null
          - tags_all              = {} -> null
          - throughput            = 0 -> null
          - volume_id             = "vol-02a8cc0e533d10b0a" -> null
          - volume_size           = 20 -> null
          - volume_type           = "gp2" -> null
            # (1 unchanged attribute hidden)
        }

      ~ secondary_network_interface (known after apply)
    }

Plan: 1 to add, 0 to change, 1 to destroy.

────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.








Plan: 1 to add, 0 to change, 1 to destroy.
aws_instance.app: Destroying... [id=i-04eefeb3f8cc97176]
aws_instance.app: Still destroying... [id=i-04eefeb3f8cc97176, 00m10s elapsed]
aws_instance.app: Still destroying... [id=i-04eefeb3f8cc97176, 00m20s elapsed]
aws_instance.app: Still destroying... [id=i-04eefeb3f8cc97176, 00m30s elapsed]
aws_instance.app: Still destroying... [id=i-04eefeb3f8cc97176, 00m40s elapsed]
aws_instance.app: Still destroying... [id=i-04eefeb3f8cc97176, 00m50s elapsed]
aws_instance.app: Destruction complete after 50s
aws_instance.app: Creating...
aws_instance.app: Still creating... [00m10s elapsed]
aws_instance.app: Creation complete after 13s [id=i-0849a5c38b88465db]

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

```
First destory happened and then creation happened.
We can change this behaviour with the help of create_before_destory lifecycle.

# 1 Create ec2 instance with ubuntu image and include the lifecycle block
```
data "aws_ami" "latest_ubuntu_image" {
    owners = ["amazon"]
    most_recent = true

    filter {
        name = "name"
        values = ["*ubuntu*"]
    }
}

resource "aws_instance" "app" {
    ami = data.aws_ami.latest_ubuntu_image.image_id
    instance_type = "t3.micro"

    lifecycle {
        create_before_destroy = true
    }
}
```

# 2 Change the image to amazon linux
The instance must be replaced since we are updating the operating system
```
data "aws_ami" "latest_ubuntu_image" {
    owners = ["amazon"]
    most_recent = true

    filter {
        name = "name"
        values = ["*al*"]
    }
}

resource "aws_instance" "app" {
    ami = data.aws_ami.latest_ubuntu_image.image_id
    instance_type = "t3.micro"

    lifecycle {
        create_before_destroy = true
    }
}
```

# 3 Perform terraform apply 
Observe that instance with amazon linux is first created and then the ubunut node is destoryed.
```
Plan: 1 to add, 0 to change, 1 to destroy.
aws_instance.app: Creating...
aws_instance.app: Still creating... [00m10s elapsed]
aws_instance.app: Creation complete after 13s [id=i-028831baec3f5c3a1]
aws_instance.app (deposed object 0ce9c033): Destroying... [id=i-0bec5eb73eba60405]
aws_instance.app: Still destroying... [id=i-0bec5eb73eba60405, 00m10s elapsed]
aws_instance.app: Still destroying... [id=i-0bec5eb73eba60405, 00m20s elapsed]
aws_instance.app: Still destroying... [id=i-0bec5eb73eba60405, 00m30s elapsed]
aws_instance.app: Still destroying... [id=i-0bec5eb73eba60405, 00m40s elapsed]
aws_instance.app: Still destroying... [id=i-0bec5eb73eba60405, 00m50s elapsed]
aws_instance.app: Still destroying... [id=i-0bec5eb73eba60405, 01m00s elapsed]
aws_instance.app: Still destroying... [id=i-0bec5eb73eba60405, 01m10s elapsed]
aws_instance.app: Still destroying... [id=i-0bec5eb73eba60405, 01m20s elapsed]

```
