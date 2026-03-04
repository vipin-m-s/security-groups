# Creating Elastic IP 

# What is ELastic IP ? 
Elastic IP is a static IPV4 address whcih wwe can create and then attach it to EC2 instance.
When ec2 instance goes down and comes back up, it will still have the Elastic IP attached and we 
can reference the ec2 instance with elastic ip address

```
provider "aws" {
    region = "ap-south-2"
}

resource "aws_eip" "lb" {
    domain = "vpc"
}
```

# 2. terraform apply -auto-approve

```
Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip.lb will be created
  + resource "aws_eip" "lb" {
      + allocation_id        = (known after apply)
      + arn                  = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = "vpc"
      + id                   = (known after apply)
      + instance             = (known after apply)
      + ipam_pool_id         = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + ptr_record           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + region               = "ap-south-2"
      + tags_all             = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_eip.lb: Creating...
aws_eip.lb: Creation complete after 1s [id=eipalloc-0195578890f2d28ab]
```