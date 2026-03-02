# Variable Definition Precendence
4 ways of defining variables are
1) default
2) *.tfvars
3) -var=""
4) export TF_VAR_

# 1. -var="" has higher precendence then export TF_VAR_
```
$ export TF_VAR_instance_type="m6.xlarge"

  
$ terraform plan -var="instance_type=m2.largfe"

Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.webapp will be created
  + resource "aws_instance" "webapp" {
      + ami                                  = "ami-4567"
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
      + instance_type                        = "m2.largfe"
```

# 2. -var="" has higher precedence then default variable 

```
$ cat variables.tf 
variable "instance_type" {
  default = "Test 1234"
}


$ terraform plan -var="instance_type=m2.largfe"

Terraform used the selected providers to generate the following execution plan. Resource
.......<redacted>..............
      + instance_state                       = (known after apply)
      + instance_type                        = "m2.largfe"
```

# 3. -var="" has higher precedence then the terraform.tfvars
```
$ cat terraform.tfvars 
instance_type="n7.large"

                                                                
$ terraform plan -var="instance_type=m2.large" 

Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.webapp will be created
  + resource "aws_instance" "webapp" {
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
      + instance_type                        = "m2.large"
```

# 4. terraform.tfvars has higher precedence then the exported TF_VAR_
```
$ echo $TF_VAR_instance_type
m6.xlarge

$ cat terraform.tfvars 
instance_type="n7.large"

$ terraform plan                              

Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.webapp will be created
  + resource "aws_instance" "webapp" {
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
      + instance_type                        = "n7.large"
```

# 5. env TF_VAR_ has higher precendence then variables.tf
```
$ cat variables.tf 
variable "instance_type" {
  default = "Test 1234"
}

$ echo $TF_VAR_instance_type
m6.xlarge


$ terraform plan            

Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.webapp will be created
  + resource "aws_instance" "webapp" {
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
      + instance_type                        = "m6.xlarge"
```
