# Latest oS


Whwen we want to fetch latest OS of ubuntu via automation, we can do it using data.

```
data "aws_ami" "latest_ubuntu_ami" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-*"]
  }
}

resource "aws_instance" "webapp" {
  ami           = data.aws_ami.latest_ubuntu_ami.image_id
  instance_type = "t3.micro"
}
```
