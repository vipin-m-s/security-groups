# List data type 

We can spcify a collection on of values for a single varibale using lists in terraform
["hehllo", 1, "abc"]

```
$ cat 7_vdf.tf 
variable "test" {}
```
```                                                               
$ terraform plan
var.test
  Enter a value: "hello"


No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.
```

# If we specify the types as list
```
$ cat main.tf 
variable "test" {
  type = list
}                                                                                 
```

```
$ terraform plan
var.test
  Enter a value: "hello"


Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Invalid value for input variable
│ 
│   on main.tf line 1:
│    1: variable "test" {
│ 
│ Unsuitable value for var.test set using an interactive prompt: list of dynamic
│ required, but have string.
```

```
$ terraform plan
var.test
  Enter a value: ["hello","world"]


No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.
```

# We can also specify the type of values the list will contain
```
$ cat main.tf 
variable "test" {
  type = list
}
```

```
$ terraform plan
var.test
  Enter a value: ["hello","world"]


Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Invalid value for input variable
│ 
│   on main.tf line 1:
│    1: variable "test" {
│ 
│ Unsuitable value for var.test set using an interactive prompt: a number is
│ required.
╵
```

```
$ terraform plan
var.test
  Enter a value: [1,2]


No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.
```

# spcifying security groups in ec2 instance
```
$ cat main.tf 
resource "aws_instance" "webapp" {
  ami = "ami-1234"
  instance_type = "t3.micro"
  vpc_security_group_ids = "sg-03e4951a68d033c35"
}
```

```                                                                                
$ terraform plan
╷
│ Error: Incorrect attribute value type
│ 
│   on main.tf line 4, in resource "aws_instance" "webapp":
│    4:   vpc_security_group_ids = "sg-03e4951a68d033c35"
│ 
│ Inappropriate value for attribute "vpc_security_group_ids": set of string
│ required, but have string.
╵
```

```
$ cat main.tf   
resource "aws_instance" "webapp" {
  ami = "ami-1234"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-03e4951a68d033c35","sg-05bbe3bfc015dcec7"]
}
```


```                                                                                 
$ terraform plan

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.webapp will be created
  + resource "aws_instance" "webapp" {
      + ami                                  = "ami-1234"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
```
