# Remote state

<img width="623" height="519" alt="Screenshot 2026-03-08 at 5 09 48 AM" src="https://github.com/user-attachments/assets/58de25d1-9bcf-44a1-a5c8-96cf8fe2ef9d" />


- Supoose netwwork team has created EIP and state file is stored in s3 bucket. EIP public ip is stored as output in s3 bucket
- Security team wants to whitelist the ip address in firewall rules

## 1. Network team creates EIP and remote backend using s3 bucket
```
➜  terraform cat main.tf
terraform {
  backend "s3" {
    bucket       = "terr-form-s3-state-store-1998"
    region       = "ap-south-2"
    key          = "terraform.tfstate"
    use_lockfile = true

  }
}

resource "aws_eip" "eip" {
  domain = "vpc"
}

output "eip_addr" {
  value = aws_eip.eip.public_ip
}
```
<img width="1142" height="157" alt="Screenshot 2026-03-08 at 7 30 18 AM" src="https://github.com/user-attachments/assets/ad7bb7d0-a0b5-424c-84f7-0c40c3c0bae7" />

<img width="1081" height="484" alt="Screenshot 2026-03-08 at 7 30 40 AM" src="https://github.com/user-attachments/assets/f509e74d-4a5a-4a29-b8a1-259153fbfd9b" />

<img width="403" height="95" alt="Screenshot 2026-03-08 at 7 33 34 AM" src="https://github.com/user-attachments/assets/fef43e40-dfec-4dbd-a400-12e871565f9c" />

## 2. Security team uses remote state data source to fetch the state information from s3 bucket

```
➜  security-team cat main.tf
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terr-form-s3-state-store-1998"
    region = "ap-south-2"
    key    = "terraform.tfstate"
  }
}

resource "aws_security_group" "dev-sg" {
  name = "dev-sg"
}

resource "aws_vpc_security_group_ingress_rule" "rule1" {
  security_group_id = aws_security_group.dev-sg.id
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  cidr_ipv4   = "${data.terraform_remote_state.vpc.outputs.eip_addr}/32"
}
```
<img width="1147" height="318" alt="Screenshot 2026-03-08 at 7 39 58 AM" src="https://github.com/user-attachments/assets/31a3666e-4f09-4cbe-baf6-d5ea917a7190" />



<img width="1145" height="192" alt="Screenshot 2026-03-08 at 7 40 17 AM" src="https://github.com/user-attachments/assets/71ae28e8-1270-47e0-ab0b-76b4257e3163" />
