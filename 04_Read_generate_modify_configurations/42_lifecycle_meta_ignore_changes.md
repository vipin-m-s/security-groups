# Lifecycle meta - ignore changes

If a terraform managed resource is updated manually via a console. Then terraform will not be aware of the changes.
So it will revert the changes back to how it is in config file. 
1) Create ec2 instance with tag
2) Login to AWS and add new tag to the ec2 instance
3) Performing terraform apply will delete the newly added tag
4) This is done because terraform will try to keep the resource as it is in config file
5) We can override this behaviour using lifecycle meta of ignore_changes.

# 1. Create ec2 instance with tag
```
data "aws_ami" "latest_ubuntu_image" {
    owners = ["amazon"]
    most_recent = true

    filter {
        name = "name"
        values = ["*al*"]
    }
}

resource "aws_instance" "app" {
    ami = data.aws_ami.latest_ubuntu_image.image_id
    instance_type = "t3.micro"
    
    tags = {
        Name = "webapp server"
    }
}
```


# 2. Login to AWS and manually add the tag to the instance
<img width="1747" height="378" alt="Screenshot 2026-03-03 at 6 44 30 PM" src="https://github.com/user-attachments/assets/b3757f02-7ed7-4f73-8266-ca34c357a847" />

# 3. Execute terraform plan command
We can see that the manually added tag is being removed by terraform
```
$ terraform plan
data.aws_ami.latest_ubuntu_image: Reading...
data.aws_ami.latest_ubuntu_image: Read complete after 2s [id=ami-0035bcd3cad6883a6]
aws_instance.app: Refreshing state... [id=i-0728ec50585f0396f]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # aws_instance.app will be updated in-place
  ~ resource "aws_instance" "app" {
        id                                   = "i-0728ec50585f0396f"
      ~ tags                                 = {
          - "Env"  = "Production" -> null
            "Name" = "webapp server"
        }
      ~ tags_all                             = {
          - "Env"  = "Production" -> null
            # (1 unchanged element hidden)
        }
        # (39 unchanged attributes hidden)

        # (9 unchanged blocks hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
```

# 4. Create ec2 instance with lifecycle meta - ignore_changes
```
data "aws_ami" "latest_ubuntu_image" {
    owners = ["amazon"]
    most_recent = true

    filter {
        name = "name"
        values = ["*al*"]
    }
}

resource "aws_instance" "app" {
    ami = data.aws_ami.latest_ubuntu_image.image_id
    instance_type = "t3.micro"
    
    tags = {
        Name = "webapp server"
    }

    lifecycle {
        ignore_changes = [tags]
    }
}
```

# 5. Now add the tag manually in AWS
<img width="378" height="219" alt="Screenshot 2026-03-03 at 6 46 39 PM" src="https://github.com/user-attachments/assets/2c1336e5-b976-4de8-a85a-b5ebbded6271" />

# 6. Execute terraform plan
We can observe how changes to the tags is ignored
```
$ terraform plan               
data.aws_ami.latest_ubuntu_image: Reading...
data.aws_ami.latest_ubuntu_image: Read complete after 3s [id=ami-0035bcd3cad6883a6]
aws_instance.app: Refreshing state... [id=i-0728ec50585f0396f]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.
$ 
```
