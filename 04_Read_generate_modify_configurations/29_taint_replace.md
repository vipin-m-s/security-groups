# Taint / replace

Imagine a scenario where team members have manually logged into an terraform managed ec2 instance and made configuration changes due to whch the app is not loading. 
Generally in an organization , ami would be present with the preconfigured images. 
So performing terraform apply is of no use, As instance already exists. 
We want to force create the ec2 instance to destory and recreate. We can achieve this via -replace command

```
data "aws_ami" "latest_ubuntu_image" {
  owners = ["amazon"]
  most_recent = true 

  filter {
    name = "name"
    values = ["*ubuntu/*"]
  }

}

resource "aws_instance" "app" {
  ami = data.aws_ami.latest_ubuntu_image.image_id
  instance_type = "t3.micro"
}
```

```
$ terraform apply -auto-approve
data.aws_ami.latest_ubuntu_image: Reading...
data.aws_ami.latest_ubuntu_image: Read complete after 1s [id=ami-091939e46367c21ee]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.app will be created
  + resource "aws_instance" "app" {
      + ami                                  = "ami-091939e46367c21ee"
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

Someone makes tge change manually
```
$ terraform apply -auto-approve
data.aws_ami.latest_ubuntu_image: Reading...
data.aws_ami.latest_ubuntu_image: Read complete after 1s [id=ami-091939e46367c21ee]
aws_instance.app: Refreshing state... [id=i-0a77bf2bad5e7d7d0]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no
differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
$ 
```

```
$ terraform apply -replace="aws_instance.app"
data.aws_ami.latest_ubuntu_image: Reading...
data.aws_ami.latest_ubuntu_image: Read complete after 0s [id=ami-091939e46367c21ee]
aws_instance.app: Refreshing state... [id=i-0a77bf2bad5e7d7d0]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_instance.app will be replaced, as requested
-/+ resource "aws_instance" "app" {
      ~ arn                                  = "arn:aws:ec2:ap-south-2:707264480025:instance/i-0a77bf2bad5e7d7d0" -> (known after apply)
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
      ~ id                                   = "i-0a77bf2bad5e7d7d0" -> (known after apply)
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
      ~ primary_network_interface_id         = "eni-022395199754460b3" -> (known after apply)
      ~ private_dns                          = "ip-172-31-8-251.ap-south-2.compute.internal" -> (known after apply)
      ~ private_ip                           = "172.31.8.251" -> (known after apply)
      ~ public_dns                           = "ec2-98-130-45-4.ap-south-2.compute.amazonaws.com" -> (known after apply)
      ~ public_ip                            = "98.130.45.4" -> (known after apply)
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
        # (7 unchanged attributes hidden)

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
          - http_put_response_hop_limit = 2 -> null
          - http_tokens                 = "required" -> null
          - instance_metadata_tags      = "disabled" -> null
        }

      ~ network_interface (known after apply)

      ~ primary_network_interface (known after apply)
      - primary_network_interface {
          - delete_on_termination = true -> null
          - network_interface_id  = "eni-022395199754460b3" -> null
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
          - iops                  = 3000 -> null
          - tags                  = {} -> null
          - tags_all              = {} -> null
          - throughput            = 125 -> null
          - volume_id             = "vol-085187a7625ef9c44" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp3" -> null
            # (1 unchanged attribute hidden)
        }

      ~ secondary_network_interface (known after apply)
    }

Plan: 1 to add, 0 to change, 1 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.app: Destroying... [id=i-0a77bf2bad5e7d7d0]
aws_instance.app: Still destroying... [id=i-0a77bf2bad5e7d7d0, 00m10s elapsed]

```
