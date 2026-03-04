# Cross Resource Attribute Reference
<img width="346" height="147" alt="Screenshot 2026-03-01 at 8 59 47 PM" src="https://github.com/user-attachments/assets/6df1997b-de55-42cd-8959-4f2e7e54d5ac" />

# 1. Create Elastic IP address 
```
resource "aws_eip" "lb" {
    domain = "vpc"
}
```

# 2. Create Security Group 
```
resource "aws_security_group" "sg" {
    name = "sg"
}
```

# 3. WHite list the Elastic IP address in security group ingress
security group resource would already be created. 
We can perform cross resource attribute reference with < resource type > < name > < attribute >

```
resource "aws_vpc_security_group_ingress_rule" "ingress" {
    security_group_id = aws_security_group.sg.id
    from_port = 80 
    to_port = 80 
    ip_protocol = "tcp"
    cidr_ipv4 = "${aws_eip.lb.public_ip}/32"
}
```

# String interpolation "${aws_eip.lb.public_ip}/32"
