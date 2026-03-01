# Cross Resource Attribute Reference

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