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
# Workflow
### 1. Create an ec2 instance
### 2. Use remote-exec provisioner to isntall ngingx on the remote server
### 3. Use local-exec provisioner to copy the public IP address of the ec2 instance and store it in file.
