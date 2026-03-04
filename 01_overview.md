# Overview


( not part of exam ) 

Provisioners are widely used in organization and allows us to use terraform for more use cases.

Provisioner allows us to execute scripts on resources post creation of the resources. 

After deploying ec2 instance, What next? Is answereed by Provisioner. 

# prvosionser
local-exec: It will help us to execute commands in the machine where terraforem is running
remote-exec: It will help us to execute scripts and commands in the remote servers/resources which were created eg. ec2 instance
file-exec

# format of provisioners

## 1. defining provisioners
Provisioners should be defined inside the resource, they should not be written outside the resource

## 2. Format of the provisioner
```
provisioner "local-exec" {}
provisioner "remote-exec" {}
```
## 3. Local exec provisioner
```
resource "aws_ec2_instance" "app" {
  ami .... 
  instsance_type....

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}
```
## 4. Remote exec provisioner 
```
resource "aws_ec2_instance" "app" {
  ami .... 
  instance_type ...

  connection {
    type = "ssh"
    user = "root"
    host = self.public_ip 
    private_key = file("./ec2.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y", 
      "sudo systemctl start ngingx",
    ]
  }
}
```
# Local exec Workflow
### Create an ec2 instance and Use local-exec provisioner to copy the public IP address of the ec2 instance and store it in file.
```
$ cat main.tf 
resource "aws_instance" "app" {
    ami = "ami-090b9c8aa1c84aefc"
    instance_type = "t3.micro"  
    count = 5   

    provisioner "local-exec" {
        command = "echo ${self.public_ip} >> ips.txt"
    }
}  
```
```
Plan: 5 to add, 0 to change, 0 to destroy.
aws_instance.app[2]: Creating...
aws_instance.app[3]: Creating...
aws_instance.app[1]: Creating...
aws_instance.app[4]: Creating...
aws_instance.app[0]: Creating...
aws_instance.app[3]: Still creating... [00m10s elapsed]
aws_instance.app[1]: Still creating... [00m10s elapsed]
aws_instance.app[2]: Still creating... [00m10s elapsed]
aws_instance.app[4]: Still creating... [00m10s elapsed]
aws_instance.app[0]: Still creating... [00m10s elapsed]
aws_instance.app[1]: Provisioning with 'local-exec'...
aws_instance.app[1] (local-exec): Executing: ["/bin/sh" "-c" "echo 18.60.39.231 >> ips.txt"]
aws_instance.app[2]: Provisioning with 'local-exec'...
aws_instance.app[2] (local-exec): Executing: ["/bin/sh" "-c" "echo 40.192.2.151 >> ips.txt"]
aws_instance.app[4]: Provisioning with 'local-exec'...
aws_instance.app[4] (local-exec): Executing: ["/bin/sh" "-c" "echo 18.61.48.194 >> ips.txt"]
aws_instance.app[1]: Creation complete after 13s [id=i-02f8f81cd36081544]
aws_instance.app[3]: Provisioning with 'local-exec'...
aws_instance.app[3] (local-exec): Executing: ["/bin/sh" "-c" "echo 16.112.130.27 >> ips.txt"]
aws_instance.app[2]: Creation complete after 13s [id=i-0a2f5637c9eb2ccc8]
aws_instance.app[4]: Creation complete after 13s [id=i-00c9550e22b45358d]
aws_instance.app[3]: Creation complete after 13s [id=i-00ed800e3ed990c90]
aws_instance.app[0]: Provisioning with 'local-exec'...
aws_instance.app[0] (local-exec): Executing: ["/bin/sh" "-c" "echo 18.61.48.107 >> ips.txt"]
aws_instance.app[0]: Creation complete after 13s [id=i-06597b32a09144235]

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
```

```
$ cat ips.txt 
18.60.39.231
40.192.2.151
18.61.48.194
16.112.130.27
18.61.48.107
```
# Remote exec Workflow
### Create an ec2 instance and Use remote-exec provisioner to host nginx application
```
resource "tls_private_key" "ec2_key" {
    algorithm = "RSA"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key =  tls_private_key.ec2_key.public_key_pem
}

resource "aws_instance" "app" {
    ami = "ami-090b9c8aa1c84aefc"
    instance_type = "t3.micro"  
    key_name = aws_key_pair.deployer.key_name 

    vpc_security_group_ids = [aws_security_group.sg.id]

    connection {
        type = "ssh"
        user = "ec2-user"
        host = self.public_ip
        private_key = tls_private_key.ec2_key.private_key_pem
    }

    provisioner "remote-exec" {
        inline = [
            "sudo dnf install nginx -y",
            "sudo systemctl start nginx",
        ]
    }
}

resource "aws_security_group" "sg" {
    name = "prod-sg"
} 

resource "aws_vpc_security_group_ingress_rule" "rule1" {
    security_group_id = aws_security_group.sg.id
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "rule2" {
    security_group_id = aws_security_group.sg.id
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
}```
<img width="1336" height="444" alt="Screenshot 2026-03-04 at 7 35 01 PM" src="https://github.com/user-attachments/assets/33607c47-6bea-468f-b4c8-8a8d5c7bf8a5" />

