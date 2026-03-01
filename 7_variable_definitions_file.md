# Variable Definitions File

# 1. It is recommended to have the values of the varables in *.tfvars file
THe project structure should be done as follows
1) main terraform configuration file
2) variables.tf
3) terraform.tfvars file

$ vi main.tf
```
resource "aws_instance" "webapp" {
  ami = var.ami
  instance_type = var.instance_type
}
```

$ vi variables.tf
```
variable "ami" {}
variable "instance_type" {}

or

variable "ami" {
  description = "The ami for the ec2 instance"
}

variable "instance_type" {
  description = "The instance type of the ec2 instance"
}
```

$ vi terraform.tfvars 
```
ami = "ami-00e42015cc6980619"
instance_type = "t3.micro"
```

# 2. If we keep the variable value default in varibales.tf and remove the value from terraform.tfvars 
Then the value will be picked from the variables.tf

# 3. If we keep the varibale value in terraform.tfvars and remove from the variables.tf. 
Then the value will be picked from terraform.tfvars

# 4. If we keep the values in both variables.tf and terraform.tfvars
Then the value will be pickled from terraform.tfvars

# 5. We can use a different name for *.tfvars file. 
If we use terraform.tfvars terraform will automatically pick the file and read variables
If we use prod.tfvars we need to explicitly specify the file name in terraform plan -var-file=prod.tfvars
