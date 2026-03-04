# Debugging

# TF_LOG

We can increase the debug logs in terraform easily using TF_LOG environment variable

By default Terraform does not show the logging
```
$ terraform plan                              
data.aws_ami.latest_ubuntu_ami: Reading...
data.aws_ami.latest_ubuntu_ami: Read complete after 1s [id=ami-0fb67e6212e8ff822]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.webapp will be created
  + resource "aws_instance" "webapp" {
      + ami                                  = "ami-0fb67e6212e8ff822"
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

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to
take exactly these actions if you run "terraform apply" now.
$
```


There are 5 levels of logging
1) TRACE
2) DEBUG
3) INFO
4) WARN
5) ERROR

Higher the value lower the log messages

```
$ export TF_LOG=INFO
$ terraform plan    
2026-03-02T20:26:56.613+0530 [INFO]  Terraform version: 1.14.6
2026-03-02T20:26:56.613+0530 [INFO]  Go runtime version: go1.25.6
2026-03-02T20:26:56.614+0530 [INFO]  CLI args: []string{"terraform", "plan"}
2026-03-02T20:26:56.614+0530 [INFO]  CLI command args: []string{"plan"}
2026-03-02T20:27:00.567+0530 [INFO]  backend/local: starting Plan operation
2026-03-02T20:27:00.579+0530 [INFO]  provider: configuring client automatic mTLS
2026-03-02T20:27:01.161+0530 [INFO]  provider.terraform-provider-aws_v6.34.0_x5: configuring server automatic mTLS: timestamp="2026-03-02T20:27:01.161+0530"
2026-03-02T20:27:03.364+0530 [INFO]  provider: plugin process exited: plugin=.terraform/providers/registry.terraform.io/hashicorp/aws/6.34.0/darwin_amd64/terraform-provider-aws_v6.34.0_x5 id=29990
2026-03-02T20:27:03.371+0530 [INFO]  provider: configuring client automatic mTLS
2026-03-02T20:27:03.946+0530 [INFO]  provider.terraform-provider-aws_v6.34.0_x5: configuring server automatic mTLS: timestamp="2026-03-02T20:27:03.946+0530"
2026-03-02T20:27:04.024+0530 [INFO]  provider: plugin process exited: plugin=.terraform/providers/registry.terraform.io/hashicorp/aws/6.34.0/darwin_amd64/terraform-provider-aws_v6.34.0_x5 id=30009
2026-03-02T20:27:04.024+0530 [INFO]  backend/local: plan calling Plan
2026-03-02T20:27:04.025+0530 [INFO]  provider: configuring client automatic mTLS
2026-03-02T20:27:04.615+0530 [INFO]  provider.terraform-provider-aws_v6.34.0_x5: configuring server automatic mTLS: timestamp="2026-03-02T20:27:04.614+0530"
2026-03-02T20:27:04.852+0530 [INFO]  provider.terraform-provider-aws_v6.34.0_x5: Retrieved credentials: tf_mux_provider="*schema.GRPCProviderServer" tf_rpc=ConfigureProvider tf_provider_addr=registry.terraform.io/hashicorp/aws tf_req_id=d7e85785-d0e1-6ea1-4639-75783c0916ba @caller=github.com/hashicorp/aws-sdk-go-base/v2@v2.0.0-beta.70/logging/tf_logger.go:39 @module=aws.aws-base tf_aws.credentials_source="SharedConfigCredentials: /Users/vipin/.aws/credentials" timestamp="2026-03-02T20:27:04.852+0530"
2026-03-02T20:27:05.041+0530 [INFO]  provider.terraform-provider-aws_v6.34.0_x5: Retrieved caller identity from STS: tf_req_id=d7e85785-d0e1-6ea1-4639-75783c0916ba @caller=github.com/hashicorp/aws-sdk-go-base/v2@v2.0.0-beta.70/logging/tf_logger.go:39 @module=aws.aws-base tf_mux_provider="*schema.GRPCProviderServer" tf_provider_addr=registry.terraform.io/hashicorp/aws tf_rpc=ConfigureProvider timestamp="2026-03-02T20:27:05.041+0530"
data.aws_ami.latest_ubuntu_ami: Reading...
data.aws_ami.latest_ubuntu_ami: Read complete after 1s [id=ami-0fb67e6212e8ff822]
2026-03-02T20:27:05.643+0530 [WARN]  Provider "registry.terraform.io/hashicorp/aws" produced an invalid plan for aws_instance.webapp, but we are tolerating it because it is using the legacy plugin SDK.
    The following problems may be the cause of any confusing errors from downstream operations:
      - .user_data_replace_on_change: planned value cty.False for a non-computed attribute
      - .source_dest_check: planned value cty.True for a non-computed attribute
      - .force_destroy: planned value cty.False for a non-computed attribute
      - .get_password_data: planned value cty.False for a non-computed attribute
      - .ephemeral_block_device: attribute representing nested block must not be unknown itself; set nested attribute values to unknown instead
      - .network_interface: attribute representing nested block must not be unknown itself; set nested attribute values to unknown instead
      - .primary_network_interface: attribute representing nested block must not be unknown itself; set nested attribute values to unknown instead
      - .secondary_network_interface: attribute representing nested block must not be unknown itself; set nested attribute values to unknown instead
      - .cpu_options: attribute representing nested block must not be unknown itself; set nested attribute values to unknown instead
      - .maintenance_options: attribute representing nested block must not be unknown itself; set nested attribute values to unknown instead
      - .metadata_options: attribute representing nested block must not be unknown itself; set nested attribute values to unknown instead
      - .private_dns_name_options: attribute representing nested block must not be unknown itself; set nested attribute values to unknown instead
      - .capacity_reservation_specification: attribute representing nested block must not be unknown itself; set nested attribute values to unknown instead
      - .ebs_block_device: attribute representing nested block must not be unknown itself; set nested attribute values to unknown instead
      - .enclave_options: attribute representing nested block must not be unknown itself; set nested attribute values to unknown instead
      - .instance_market_options: attribute representing nested block must not be unknown itself; set nested attribute values to unknown instead
      - .root_block_device: attribute representing nested block must not be unknown itself; set nested attribute values to unknown instead
2026-03-02T20:27:05.665+0530 [INFO]  provider: plugin process exited: plugin=.terraform/providers/registry.terraform.io/hashicorp/aws/6.34.0/darwin_amd64/terraform-provider-aws_v6.34.0_x5 id=30010
2026-03-02T20:27:05.667+0530 [INFO]  backend/local: plan operation completed

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.webapp will be created
  + resource "aws_instance" "webapp" {
      + ami                                  = "ami-0fb67e6212e8ff822"
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

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to
take exactly these actions if you run "terraform apply" now.
```


# TF_LOG_PATH

If we do not want to clutter the standard output with logging lines, we can choose to put the logs to a file using
TF_LOG_PATH envieronment variable. 
Standard output will not have logs
FIle will have all the logs
```

$ export TF_LOG_PATH="info_logs"
$ export TF_LOG=INFO            
$ terraform plan                
data.aws_ami.latest_ubuntu_ami: Reading...
data.aws_ami.latest_ubuntu_ami: Read complete after 0s [id=ami-0fb67e6212e8ff822]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.webapp will be created
  + resource "aws_instance" "webapp" {
      + ami                                  = "ami-0fb67e6212e8ff822"
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

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to
take exactly these actions if you run "terraform apply" now.
$ 
```


```
$ cat info_logs 
2026-03-02T20:28:13.543+0530 [INFO]  Terraform version: 1.14.6
2026-03-02T20:28:13.543+0530 [INFO]  Go runtime version: go1.25.6
2026-03-02T20:28:13.544+0530 [INFO]  CLI args: []string{"terraform", "plan"}
2026-03-02T20:28:13.545+0530 [INFO]  CLI command args: []string{"plan"}
2026-03-02T20:28:17.067+0530 [INFO]  backend/local: starting Plan operation
2026-03-02T20:28:17.071+0530 [INFO]  provider: configuring client automatic mTLS
2026-03-02T20:28:17.602+0530 [INFO]  provider.terraform-provider-aws_v6.34.0_x5: configuring server automatic mTLS: timestamp="2026-03-02T20:28:17.601+0530"
2026-03-02T20:28:19.391+0530 [INFO]  provider: plugin process exited: plugin=.terraform/providers/registry.terraform.io/hashicorp/aws/6.34.0/darwin_amd64/terraform-provider-aws_v6.34.0_x5 id=30623
2026-03-02T20:28:19.393+0530 [INFO]  provider: configuring client automatic mTLS
2026-03-02T20:28:19.967+0530 [INFO]  provider.terraform-provider-aws_v6.34.0_x5: configuring server automatic mTLS: timestamp="2026-03-02T20:28:19.967+0530"
2026-03-02T20:28:20.034+0530 [INFO]  provider: plugin process exited: plugin=.terraform/providers/registry.terraform.io/hashicorp/aws/6.34.0/darwin_amd64/terraform-provider-aws_v6.34.0_x5 id=30634
```
