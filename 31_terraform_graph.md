# terraform graph

We can visualize the dependencies of each terraform resource using terraform graph command. 
It will be outputted in dot language. We can use graphviz to view the dependency graph. 
or we can install grpahviz and use dot command to create png/svg file in our local env.

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }

  }
}

provider "aws" {
  region = "ap-south-2"
}


resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/17"
  availability_zone       = "ap-south-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.128.0/17"
  availability_zone       = "ap-south-2b"
  map_public_ip_on_launch = true
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt.id
}


resource "aws_security_group" "webapp_sg" {
  name   = "web-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "s3" {
  bucket = "vipin-m-s-terraform"
}

resource "aws_instance" "webserver1" {
  ami                    = "ami-090b9c8aa1c84aefc"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webapp_sg.id]
  subnet_id              = aws_subnet.subnet1.id
  user_data              = <<-EOF
                #!/bin/bash 
                python -m http.server 80
                EOF
}

resource "aws_instance" "webserver2" {
  ami                    = "ami-090b9c8aa1c84aefc"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webapp_sg.id]
  subnet_id              = aws_subnet.subnet2.id
  user_data              = <<-EOF
                #!/bin/bash
                sudo dnf install python -y
                sudo dnf install tmux -y
                tmux new-session -d -s webapp 'python -m http.server 80'
                EOF
}


resource "aws_lb" "lb" {
  name               = "webapp-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.webapp_sg.id]
  subnets         = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_lb_target_group" "webapp-tg" {
  name     = "webapp-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {

    path = "/"
    port = "traffic-port"

  }
}


resource "aws_lb_target_group_attachment" "tg-attach1" {
  target_group_arn = aws_lb_target_group.webapp-tg.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg-attach2" {
  target_group_arn = aws_lb_target_group.webapp-tg.arn
  target_id        = aws_instance.webserver2.id
  port             = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.webapp-tg.arn
    type             = "forward"
  }
}
```


```
$ terraform graph 
digraph G {
  rankdir = "RL";
  node [shape = rect, fontname = "sans-serif"];
  "aws_iam_user.dev-users" [label="aws_iam_user.dev-users"];
  "aws_instance.webserver1" [label="aws_instance.webserver1"];
  "aws_instance.webserver2" [label="aws_instance.webserver2"];
  "aws_internet_gateway.igw" [label="aws_internet_gateway.igw"];
  "aws_lb.lb" [label="aws_lb.lb"];
  "aws_lb_listener.listener" [label="aws_lb_listener.listener"];
  "aws_lb_target_group.webapp-tg" [label="aws_lb_target_group.webapp-tg"];
  "aws_lb_target_group_attachment.tg-attach1" [label="aws_lb_target_group_attachment.tg-attach1"];
  "aws_lb_target_group_attachment.tg-attach2" [label="aws_lb_target_group_attachment.tg-attach2"];
  "aws_route_table.rt" [label="aws_route_table.rt"];
  "aws_route_table_association.rta1" [label="aws_route_table_association.rta1"];
  "aws_route_table_association.rta2" [label="aws_route_table_association.rta2"];
  "aws_s3_bucket.s3" [label="aws_s3_bucket.s3"];
  "aws_security_group.webapp_sg" [label="aws_security_group.webapp_sg"];
  "aws_subnet.subnet1" [label="aws_subnet.subnet1"];
  "aws_subnet.subnet2" [label="aws_subnet.subnet2"];
  "aws_vpc.vpc" [label="aws_vpc.vpc"];
  "aws_instance.webserver1" -> "aws_security_group.webapp_sg";
  "aws_instance.webserver1" -> "aws_subnet.subnet1";
  "aws_instance.webserver2" -> "aws_security_group.webapp_sg";
  "aws_instance.webserver2" -> "aws_subnet.subnet2";
  "aws_internet_gateway.igw" -> "aws_vpc.vpc";
  "aws_lb.lb" -> "aws_security_group.webapp_sg";
  "aws_lb.lb" -> "aws_subnet.subnet1";
  "aws_lb.lb" -> "aws_subnet.subnet2";
  "aws_lb_listener.listener" -> "aws_lb.lb";
  "aws_lb_listener.listener" -> "aws_lb_target_group.webapp-tg";
  "aws_lb_target_group.webapp-tg" -> "aws_vpc.vpc";
  "aws_lb_target_group_attachment.tg-attach1" -> "aws_instance.webserver1";
  "aws_lb_target_group_attachment.tg-attach1" -> "aws_lb_target_group.webapp-tg";
  "aws_lb_target_group_attachment.tg-attach2" -> "aws_instance.webserver2";
  "aws_lb_target_group_attachment.tg-attach2" -> "aws_lb_target_group.webapp-tg";
  "aws_route_table.rt" -> "aws_internet_gateway.igw";
  "aws_route_table_association.rta1" -> "aws_route_table.rt";
  "aws_route_table_association.rta1" -> "aws_subnet.subnet1";
  "aws_route_table_association.rta2" -> "aws_route_table.rt";
  "aws_route_table_association.rta2" -> "aws_subnet.subnet2";
  "aws_security_group.webapp_sg" -> "aws_vpc.vpc";
  "aws_subnet.subnet1" -> "aws_vpc.vpc";
  "aws_subnet.subnet2" -> "aws_vpc.vpc";
}
```

<img width="1110" height="614" alt="Screenshot 2026-03-03 at 5 36 56 AM" src="https://github.com/user-attachments/assets/f8cf1fbb-16b4-41f7-8a16-2e7b4078aa28" />

```
$ terraform graph | dot -Tpng >graph.png

$ ls -ltr | grep graph.png 
-rw-r--r--@ 1 vipin  staff   73913 Mar  3 05:38 graph.png
```
