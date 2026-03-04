# Dynamic blocks

Suppose we are creating multiple resources such as inbound/outbound rules within a security group. 
If there are 50-100 rules within a security group we should not be adding it statically in our code. 
We would violate the DRY principle.  hence we should use Dynamic block. 
Terraform internally will create the resources. It makes our code cleaner and easy to maintain

```
resource "aws_security_group" "sg" {
  name = "sg"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cirdr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cirdr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cirdr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 6789
    to_port = 6789
    protocol = "tcp"
    cirdr_blocks = ["0.0.0.0/0"]
  }

}
```

We can replace the above code as below 
```
$ cat one.tf 
variable "ports" {
  default = [80, 22, 8080, 6789]
}

resource "aws_security_group" "sg" {
  name = "sg"

  dynamic ingress {
    for_each = var.ports
    content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
  }

}%                                                                                      
$ terraform plan

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_security_group.sg will be created
  + resource "aws_security_group" "sg" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
```
<img width="1621" height="767" alt="Screenshot 2026-03-02 at 9 15 01 PM" src="https://github.com/user-attachments/assets/ff15060a-a071-4140-b4d8-1c76a1432471" />

