# security-groups
Firewalls in AWS via terraform

# 1. Create security group. This will not add rules

```
provider "aws" {
	region = "ap-south-2"
}

resource "aws_security_group" "allow_http" {
	name = "allow_http"
	description = "allow http"
}
```
# 2. Create Ingress and Egress rules
```
provider "aws" {
	region = "ap-south-2"
}

resource "aws_security_group" "allow_http" {
	name = "allow_http"
	description = "allow http"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_rule" {
	security_group_id = aws_security_group.allow_http.id
	from_port = 80
	to_port = 80
	ip_protocol = "tcp"
	cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
	security_group_id = aws_security_group.allow_http.id
	ip_protocol = "-1"
	cidr_ipv4 = "0.0.0.0/0"
} 

```
<img width="1618" height="630" alt="Screenshot 2026-03-01 at 6 09 28 PM" src="https://github.com/user-attachments/assets/211c6b56-0099-42ba-8090-aa841a6fac55" />


<img width="1623" height="619" alt="Screenshot 2026-03-01 at 6 09 40 PM" src="https://github.com/user-attachments/assets/3c688564-992d-439b-9e76-37d0b16f1ac4" />


# 3. We can also include FROM and TO port. To allow in ports in the range of 80 - 100. 
This will modify existing rule which has only port 80 and update it to port 80-100
```
provider "aws" {
	region = "ap-south-2"
}

resource "aws_security_group" "allow_http" {
	name = "allow_http"
	description = "allow http"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_rule" {
	security_group_id = aws_security_group.allow_http.id
	from_port = 80
	to_port = 100
	ip_protocol = "tcp"
	cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
	security_group_id = aws_security_group.allow_http.id
	ip_protocol = "-1"
	cidr_ipv4 = "0.0.0.0/0"
} 

```
<img width="1613" height="431" alt="Screenshot 2026-03-01 at 6 11 13 PM" src="https://github.com/user-attachments/assets/eabfc3f9-9a7c-44d2-99fc-a704cb9c09d5" />


# 4. We can also specify the security group ID manually for the rules
Updated the Security group ID of default gateway 
THis will delete the rule from our custom security group
and then the Rule will be added to default security group
```
provider "aws" {
	region = "ap-south-2"
}

resource "aws_security_group" "allow_http" {
	name = "allow_http"
	description = "allow http"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_rule" {
	security_group_id = "sg-03e4951a68d033c35"
	from_port = 80
	to_port = 100
	ip_protocol = "tcp"
	cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
	security_group_id = aws_security_group.allow_http.id
	ip_protocol = "-1"
	cidr_ipv4 = "0.0.0.0/0"
} 

```

# 5. Destroy created resources
$ terraform destroy
