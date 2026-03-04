provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}

variable "tags" {
  default = ["firstec2", "secondec2"]
}

variable "ami" {
  default = {
    "us-east-1" = "ami-0f3caa1cf4417e51b"
    "us-east-2" = "ami-09256c524fab91d36"
  }
}

resource "aws_instance" "webapp" {
  ami = lookup(var.ami, var.region)
  instance_type = "t3.micro"
  count = length(var.tags)

  tags = {
    Name = element(var.tags,count.index)
    Creationdate = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp()) 
  }
}
