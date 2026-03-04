# Precondition - postcondition - lifecycle

Suppose we want to add some pre conditions and post conditions before and after creation of resources.

## 1. Developer requests for a m5.xlarge instance for dev environemnt. This should be blocked as it will cost more to the company.
Currently there is no restriction
```
$ cat main.tf 
variable "instance_type" {}

resource "aws_instance" "app" {
    ami = "ami-123"
    instance_type = var.instance_type
}%                                                                          
$ terraform plan
var.instance_type
  Enter a value: m5.xlarge


Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.app will be created
  + resource "aws_instance" "app" {
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

## 2. We can add a precondition block to restrict devs from requesting big servers
```
$ cat main.tf 
variable "instance_type" {}

data "aws_ec2_instance_type" "type" {
    instance_type = var.instance_type
}

output "out" {
    value = data.aws_ec2_instance_type.type
}

$ terraform plan
var.instance_type
  Enter a value: m5.xlarge

data.aws_ec2_instance_type.type: Reading...
data.aws_ec2_instance_type.type: Read complete after 0s [id=m5.xlarge]

Changes to Outputs:
  + out = {
      + auto_recovery_supported              = true
      + bandwidth_weightings                 = []
      + bare_metal                           = false
      + boot_modes                           = [
          + "legacy-bios",
          + "uefi",
        ]
      + burstable_performance_supported      = false
      + current_generation                   = false
      + dedicated_hosts_supported            = true
      + default_cores                        = 2
      + default_network_card_index           = 0
      + default_threads_per_core             = 2
      + default_vcpus                        = 4
      + ebs_encryption_support               = "supported"
      + ebs_nvme_support                     = "required"
      + ebs_optimized_support                = "default"
      + ebs_performance_baseline_bandwidth   = 1150
      + ebs_performance_baseline_iops        = 6000
      + ebs_performance_baseline_throughput  = 143.75
      + ebs_performance_maximum_bandwidth    = 4750
      + ebs_performance_maximum_iops         = 18750
      + ebs_performance_maximum_throughput   = 593.75
      + efa_maximum_interfaces               = null
      + efa_supported                        = false
      + ena_srd_supported                    = false
      + ena_support                          = "required"
      + encryption_in_transit_supported      = false
      + fpgas                                = []
      + free_tier_eligible                   = false
      + gpus                                 = []
      + hibernation_supported                = true
      + hypervisor                           = "nitro"
      + id                                   = "m5.xlarge"
      + inference_accelerators               = []
      + instance_disks                       = []
      + instance_storage_supported           = false
      + instance_type                        = "m5.xlarge"
      + ipv6_supported                       = true
      + maximum_ipv4_addresses_per_interface = 15
      + maximum_ipv6_addresses_per_interface = 15
      + maximum_network_cards                = 1
      + maximum_network_interfaces           = 4
      + media_accelerators                   = []
      + memory_size                          = 16384
      + network_cards                        = [
          + {
              + baseline_bandwidth = 1.25
              + index              = 0
              + maximum_interfaces = 4
              + peak_bandwidth     = 10
              + performance        = "Up to 10 Gigabit"
            },
        ]
      + network_performance                  = "Up to 10 Gigabit"
      + neuron_devices                       = []
      + nitro_enclaves_support               = "supported"
      + nitro_tpm_support                    = "supported"
      + nitro_tpm_supported_versions         = [
          + "2.0",
        ]
      + phc_support                          = "unsupported"
      + region                               = "ap-south-2"
      + supported_architectures              = [
          + "x86_64",
        ]
      + supported_cpu_features               = []
      + supported_placement_strategies       = [
          + "cluster",
          + "partition",
          + "spread",
        ]
      + supported_root_device_types          = [
          + "ebs",
        ]
      + supported_usages_classes             = [
          + "on-demand",
          + "spot",
        ]
      + supported_virtualization_types       = [
          + "hvm",
        ]
      + sustained_clock_speed                = 3.1
      + timeouts                             = null
      + total_fpga_memory                    = null
      + total_gpu_memory                     = null
      + total_inference_memory               = null
      + total_instance_storage               = null
      + total_media_memory                   = null
      + total_neuron_device_memory           = null
      + valid_cores                          = [
          + 2,
        ]
      + valid_threads_per_core               = [
          + 1,
          + 2,
        ]
    }

```

```
$ cat main.tf 
variable "instance_type" {}

data "aws_ec2_instance_type" "type" {
    instance_type = var.instance_type
}

resource "aws_instance" "app" {
    ami = "ami-123"
    instance_type = var.instance_type

    lifecycle {
        precondition {
            condition = data.aws_ec2_instance_type.type.free_tier_eligible
            error_message = "Select free tier instance"
        }
    }
}%                                                                          
$ terraform plan
var.instance_type
  Enter a value: m5.xlarge

data.aws_ec2_instance_type.type: Reading...
data.aws_ec2_instance_type.type: Read complete after 0s [id=m5.xlarge]

Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Resource precondition failed
│ 
│   on main.tf line 13, in resource "aws_instance" "app":
│   13:             condition = data.aws_ec2_instance_type.type.free_tier_eligible
│     ├────────────────
│     │ data.aws_ec2_instance_type.type.free_tier_eligible is false
│ 
│ Select free tier instance
╵
$ terraform plan
var.instance_type
  Enter a value: t3.micro

data.aws_ec2_instance_type.type: Reading...
data.aws_ec2_instance_type.type: Read complete after 0s [id=t3.micro]

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.app will be created
  + resource "aws_instance" "app" {
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

## 3. Suppose the devs are using ec2 instances without public IPS. 
We can add post condition to ensure public ip is created for the created ec2 instance
+ In post condition we can use self. Since the ec2 instance is already created
+ We cannot use self in precondition as the resource is not created
```
$ cat main.tf 
variable "instance_type" {}

data "aws_ec2_instance_type" "type" {
    instance_type = var.instance_type
}

resource "aws_instance" "app" {
    ami = "ami-090b9c8aa1c84aefc"
    instance_type = var.instance_type

    lifecycle {
        precondition {
            condition = data.aws_ec2_instance_type.type.free_tier_eligible
            error_message = "Select free tier instance"
        }

        postcondition {
            condition = self.public_ip != ""
            error_message = "Public IP is empty"
        }
    }
}%     
```

```
Plan: 1 to add, 0 to change, 0 to destroy.
aws_instance.app: Creating...
aws_instance.app: Still creating... [00m10s elapsed]
aws_instance.app: Creation complete after 13s [id=i-0ffbcaf7c5a0fc8be]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

```
variable "instance_type" {}

data "aws_ec2_instance_type" "type" {
    instance_type = var.instance_type
}

resource "aws_instance" "app" {
    ami = "ami-090b9c8aa1c84aefc"
    instance_type = var.instance_type

    lifecycle {
        precondition {
            condition = data.aws_ec2_instance_type.type.free_tier_eligible
            error_message = "Select free tier instance"
        }

        postcondition {
            condition = self.public_ip == ""
            error_message = "Public IP is empty"
        }
    }
}
```

```
$ terraform apply -auto-approve
var.instance_type
  Enter a value: t3.micro

data.aws_ec2_instance_type.type: Reading...
data.aws_ec2_instance_type.type: Read complete after 0s [id=t3.micro]
aws_instance.app: Refreshing state... [id=i-0ffbcaf7c5a0fc8be]

Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Resource postcondition failed
│ 
│   on main.tf line 18, in resource "aws_instance" "app":
│   18:             condition = self.public_ip == ""
│     ├────────────────
│     │ self.public_ip is "18.61.163.99"
│ 
│ Public IP is empty
```
