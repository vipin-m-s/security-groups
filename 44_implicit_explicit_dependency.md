# Dependencies- Implicit and Explicit

# Explicit dependencies
When we manually add depends_on in a resource block we call it explicit dependency. 

# Implicit dependency 
When we create resources and reference one resource in another resource. We call it implicit dependency

By default the ec2 instance will be added in default security group
```
resource "aws_instance" "app" {
    ami = "ami-0035bcd3cad6883a6"
    instance_type = "t3.micro"
}

resource "aws_security_group" "prod-sg" {
    name = "prod-sg"
}
```

So inorder to add ec2 instance in the created security group. 
We need the id of the security group. Hence the sg should already be created.

```
resource "aws_instance" "app" {
    ami = "ami-0035bcd3cad6883a6"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.prod_sg.id]
}

resource "aws_security_group" "prod_sg" {
    name = "prod-sg"
}
```
This way the security group will be created first and then id will be replaced in the ec2 isntance. 
Hence the ec2 instance and the prod-sg will be linked,

```
Plan: 2 to add, 0 to change, 0 to destroy.
aws_security_group.prod_sg: Creating...
aws_security_group.prod_sg: Creation complete after 2s [id=sg-0570679d403897be5]
aws_instance.app: Creating...
aws_instance.app: Still creating... [00m10s elapsed]
aws_instance.app: Creation complete after 13s [id=i-0b1aa22e979a24049]
```
