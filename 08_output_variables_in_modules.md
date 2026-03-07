# Output variables in modules

- When we want to cross reference attributes in terraform
- If the resources are in the same project, It is possible
- But when the resources accessing the attributes are in different folder
- Then we cannot directly access the attributes.
- Since we do not know if the resource is created or not.
- Attributes are taken from the .tf state file

  <img width="1120" height="416" alt="Screenshot 2026-03-07 at 9 01 34 AM" src="https://github.com/user-attachments/assets/5bd0d4e2-dd95-4d39-a9f4-91d6bb851e33" />


  ## We have to utilize the output variables here

  <img width="1140" height="441" alt="Screenshot 2026-03-07 at 9 02 55 AM" src="https://github.com/user-attachments/assets/a1e5809f-5580-4d2c-a156-196829901994" />

modules/ec2/main.tf
```
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 6.35.1"
        }
    }
}

resource "aws_instance" "webapp" {
    ami = var.ami
    instance_type = var.instance_type
}

variable "ami" {}
variable "instance_type" {}

output "instance_id" {
    value = aws_instance.webapp.id
}
```

teams/A/main.tf
```
provider "aws" {
    region = "us-east-1"
}

module "ec2" {
    source = "../../modules/ec2"
    ami = "test-ami"
    instance_type = "m5.xlarge"
}

resource "aws_eip" "lb" {
    domain = "vpc"
    instance = module.ec2.instance_id
}

```
<img width="1136" height="183" alt="Screenshot 2026-03-07 at 9 07 03 AM" src="https://github.com/user-attachments/assets/2cfd556b-2731-4149-b0fc-f3d57fd3a999" />

<img width="1130" height="466" alt="Screenshot 2026-03-07 at 9 07 18 AM" src="https://github.com/user-attachments/assets/2f8e5c46-7aea-4690-bc97-8026f32a313e" />

