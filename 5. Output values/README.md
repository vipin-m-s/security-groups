# Output values
We can output certain attributes of a resource
Once the resource is created this can be useful for the user
of the terraform 

# 1. Create Elastic IP 
```
provider "aws" {
    region = "ap-south-1"
}

resource "aws_eip" "lb" {
    domain = "vpc"
}

output "public-ip" {
    value = "http://${aws_eip.lb.public_ip}:8080"
}
```

# 2. Perform terraform apply
$ terraform apply
```
Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
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
      + region               = "ap-south-1"
      + tags_all             = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + public-ip = (known after apply)
aws_eip.lb: Creating...
aws_eip.lb: Creation complete after 2s [id=eipalloc-04343b830ac00f405]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

public-ip = "http://3.111.78.155:8080"
```

# 3. We can also not provide the attribute 
In that case every attribute will be printed
```
output "public-ip" {
    value = aws_eip.lb
}
```

```
Outputs:

public-ip = {
  "address" = tostring(null)
  "allocation_id" = "eipalloc-04343b830ac00f405"
  "arn" = "arn:aws:ec2:ap-south-1:707264480025:elastic-ip/eipalloc-04343b830ac00f405"
  "associate_with_private_ip" = tostring(null)
  "association_id" = ""
  "carrier_ip" = ""
  "customer_owned_ip" = ""
  "customer_owned_ipv4_pool" = ""
  "domain" = "vpc"
  "id" = "eipalloc-04343b830ac00f405"
  "instance" = ""
  "ipam_pool_id" = tostring(null)
  "network_border_group" = "ap-south-1"
  "network_interface" = ""
  "private_dns" = tostring(null)
  "private_ip" = ""
  "ptr_record" = ""
  "public_dns" = "ec2-3-111-78-155.ap-south-1.compute.amazonaws.com"
  "public_ip" = "3.111.78.155"
  "public_ipv4_pool" = "amazon"
  "region" = "ap-south-1"
  "tags" = tomap({})
  "tags_all" = tomap({})
  "timeouts" = null /* object */
}
```

# 4. The output values also can be refernced form other terraform projectsif they have access to state files

state files store the outputs aswell
```
  "outputs": {
    "public-ip": {
      "value": {
        "address": null,
        "allocation_id": "eipalloc-04343b830ac00f405",
        "arn": "arn:aws:ec2:ap-south-1:707264480025:elastic-ip/eipalloc-04343b830ac00f405",
        "associate_with_private_ip": null,
```