# terraform validate


  ```
$ cat one.tf 
resource "aws_instance" "app" {
  ami = "ami-123"
  instance_type = "t3.micro"
}
```
```
$ terraform validate
Success! The configuration is valid.
```

```
$ cat one.tf        
resource "aws_instance" "app" {
  ami = "ami-123"
  instance_type = "t3.micro"
  sky = "blue"
}```

```                                                                                      
$ terraform validate
╷
│ Error: Unsupported argument
│ 
│   on one.tf line 4, in resource "aws_instance" "app":
│    4:   sky = "blue"
│ 
│ An argument named "sky" is not expected here.
╵
```

Terraform plan also internally performs validation
```
$ cat one.tf    
resource "aws_instance" "app" {
  ami = "ami-123"
  instance_type = var.instance_type
}%                                                                                      
$ terraform validate
╷
│ Error: Reference to undeclared input variable
│ 
│   on one.tf line 3, in resource "aws_instance" "app":
│    3:   instance_type = var.instance_type
│ 
│ An input variable with the name "instance_type" has not been declared. This variable
│ can be declared with a variable "instance_type" {} block.
╵
$ terraform plan 
╷
│ Error: Reference to undeclared input variable
│ 
│   on one.tf line 3, in resource "aws_instance" "app":
│    3:   instance_type = var.instance_type
│ 
│ An input variable with the name "instance_type" has not been declared. This variable
│ can be declared with a variable "instance_type" {} block.
╵
$ 

```
