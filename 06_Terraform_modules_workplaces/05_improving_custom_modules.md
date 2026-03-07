# custom modules

There are few issues with the module that we have written

## 1. Hardcoding of options
- We have hard coded the ami and the instance_type in the code
- The developers if they want a differnet ami and instance_type they cannot choose it
- By default the hardcoded values are taken into consideration

```
resource "aws_instance" "webapp" {
    ami = "ami-090b9c8aa1c84aefc"
    instance_type = "t3.micro"
}
```

If the dev makes below call 
```
module "ec2" {
    source = "../../modules/ec2"
    instance_type = "t2/large"
}


➜  A terraform apply -auto-approve
╷
│ Error: Unsupported argument
│ 
│   on main.tf line 3, in module "ec2":
│    3:     instance_type = "t2/large"
│ 
│ An argument named "instance_type" is not expected here.
```

## 2. hardcoding of AWS region 
- If a dev wants to create a ec2 instance in different region
- It is not possible, It will be created in same region in which region is present in module

module/wc2/main.tf
```
provider "aws" {
    region = "ap-south-2"
}

resource "aws_instance" "webapp" {
    ami = "ami-090b9c8aa1c84aefc"
    instance_type = "t3.micro"
}
```

This provider region will be ignored
```
provider "aws" {
    region = "us-east-1"
}

module "ec2" {
    source = "../../modules/ec2"
}
```

Instead of hardcodinf of provider region, we need to hardcode the required_providers block
```
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 5.5.0"
        }
    }
}

resource "aws_instance" "webapp" {
    ami = "ami-090b9c8aa1c84aefc"
    instance_type = "t3.micro"
}
```
