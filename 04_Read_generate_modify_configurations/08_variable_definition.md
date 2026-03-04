# Ways of Defining variables

# 1 . We can assign a value to a variable via the variables.tf file

$ cat variables.tf
```
variable "instance_type" {
  default = "t2.micro"
}
```

# 2. We can assign a value to  a variable via terraform.tfvars file
$ cat terraform.tfvars
```
instance_type = "t2.micro"
```

# 3. If we do not specify the varibale values in both defaults and tfvars file. Then when running terraform plan, It will prompt for the variable value

$  terraform plan
```
var.instance_type
  Enter a value: 
```

# 4. We can also directly specify the variable via command line using -var
```
$ terraform plan -var="instance_type=m2.largfe"

Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.webapp will be created
  + resource "aws_instance" "webapp" {
      + ami                                  = "ami-4567"
      + arn                                  = (known after apply)
.........<redacted>..............
      + instance_type                        = "m2.largfe"
```

# 5. We can also provide value to the varibale via environment variables
```
$ export TF_VAR_instance_type="m6.xlarge"

$ terraform plan                               

Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.webapp will be created
  + resource "aws_instance" "webapp" {
      + ami                                  = "ami-4567"
      + arn                                  = (known after apply)
.........<redacted>..........
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "m6.xlarge"
```
