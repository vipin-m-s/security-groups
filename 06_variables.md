# Varibales in terraform 

<img width="1094" height="392" alt="Screenshot 2026-03-01 at 9 28 35 PM" src="https://github.com/user-attachments/assets/80cc8254-adbb-49ee-a2c1-a046761343e4" />


<img width="1590" height="306" alt="Screenshot 2026-03-01 at 9 28 45 PM" src="https://github.com/user-attachments/assets/2ec6907e-0015-4114-bbe5-3138892f3c42" />

# 1. When there are multiple rules present with same static IP address. If in future the hardcoded IP of VPN server changes. Then we need to manually update all the IP address and cause human errors in  the process. 
```
provider "aws" {
    region = "ap-south-1"
}

resource "aws_security_group" "webapp-sg" {
    name = "webapp-sg"
}

resource "aws_vpc_security_group_ingress_rule" "rule1" {
    security_group_id = aws_security_group.webapp-sg.id
    from_port = 80
    to_port = 80 
    ip_protocol = "tcp"
    cidr_ipv4 = "10.11.121.12/32"
}


resource "aws_vpc_security_group_ingress_rule" "rule2" {
    security_group_id = aws_security_group.webapp-sg.id
    from_port = 443
    to_port = 443
    ip_protocol = "tcp"
    cidr_ipv4 = "10.11.121.12/32"
}


resource "aws_vpc_security_group_ingress_rule" "rule3" {
    security_group_id = aws_security_group.webapp-sg.id
    from_port = 8080
    to_port = 8080
    ip_protocol = "tcp"
    cidr_ipv4 = "10.11.121.12/32"
}


resource "aws_vpc_security_group_ingress_rule" "rule4" {
    security_group_id = aws_security_group.webapp-sg.id
    from_port = 8001
    to_port = 8001
    ip_protocol = "tcp"
    cidr_ipv4 = "10.11.121.12/32"
}
```
# 2. We should make use of varibales to parameterise and store the IP address in central location .SO when the IP changes in future. The core terraform configuration file is unchanges. ONly the central file needs to be updated. 
Reducing the errors

$ vi variables.tf
```
variable "vpn_ip_address" {
    default = "10.121.32.14/32"
}
```


# 3 .Replace all the static references with the varibale 

$ vi main.tf
```
provider "aws" {
    region = "ap-south-1"
}

resource "aws_security_group" "webapp-sg" {
    name = "webapp-sg"
}

resource "aws_vpc_security_group_ingress_rule" "rule1" {
    security_group_id = aws_security_group.webapp-sg.id
    from_port = 80
    to_port = 80 
    ip_protocol = "tcp"
    cidr_ipv4 = var.vpn_ip_address
}


resource "aws_vpc_security_group_ingress_rule" "rule2" {
    security_group_id = aws_security_group.webapp-sg.id
    from_port = 443
    to_port = 443
    ip_protocol = "tcp"
    cidr_ipv4 = var.vpn_ip_address
}


resource "aws_vpc_security_group_ingress_rule" "rule3" {
    security_group_id = aws_security_group.webapp-sg.id
    from_port = 8080
    to_port = 8080
    ip_protocol = "tcp"
    cidr_ipv4 = var.vpn_ip_address
}


resource "aws_vpc_security_group_ingress_rule" "rule4" {
    security_group_id = aws_security_group.webapp-sg.id
    from_port = 8001
    to_port = 8001
    ip_protocol = "tcp"
    cidr_ipv4 = var.vpn_ip_address
}
```
# 4. Any changes to IP , just modify the varibales in central file
