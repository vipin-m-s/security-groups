# root vs child module

## root module
- The module from which we call another module is called root module.
- entry point into the terraform configuration

teams/A/main.tf
```
provider "aws" {
    region = "ap-south-2"
}

module "ec2" {
    source = "../../modules/ec2"
    ami = "ami-090b9c8aa1c84aefc"
    instance_type = "t3.micro"
}

resource "aws_eip" "lb" {
    domain = "vpc"
    instance = module.ec2.instance_id
}
````

## child module

The module which is being called is called as child module
Exmaple:- ec2 module is called module
