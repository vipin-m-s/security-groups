# Lifecycle - Prevent destory

In production environment we do not want some of the important resources to be destoryed accidentally such as database resources.
Destorying the database reosurces can lead to data loss.
We can prevent resource destruction using the lifecycle meta - prevent_destroy. 
However if the resource block is removed and apply is done. Then the resource will be destoryed

# 1. Create an ec2 instance without prevent_destroy lifecycle meta
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
}
```

# 2. Execute destory command to destory the ec2 instance

```
$ terraform destroy -auto-approve
data.aws_ami.latest_ubuntu_image: Reading...
data.aws_ami.latest_ubuntu_image: Read complete after 2s [id=ami-0035bcd3cad6883a6]
aPlan: 0 to add, 0 to change, 1 to destroy.
.............
aws_instance.app: Destroying... [id=i-028831baec3f5c3a1]
aws_instance.app: Still destroying... [id=i-028831baec3f5c3a1, 00m10s elapsed]
aws_instance.app: Still destroying... [id=i-028831baec3f5c3a1, 00m20s elapsed]
aws_instance.app: Destruction complete after 30s

Destroy complete! Resources: 1 destroyed.
```

As we can see destorying ec2 instance is possible

# 3. Now lets create ec2 instance with lifecycle meta of prevent_destroy.

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
    
    lifecycle {
        prevent_destroy = true
    }
}
```

# 4. Try to destory the ec2 instance now. It should fail
```
Plan: 0 to add, 0 to change, 1 to destroy.
╷
│ Error: Instance cannot be destroyed
│ 
│   on main.tf line 11:
│   11: resource "aws_instance" "app" {
│ 
│ Resource aws_instance.app has lifecycle.prevent_destroy set, but the plan
│ calls for this resource to be destroyed. To avoid this error and continue with
│ the plan, either disable lifecycle.prevent_destroy or reduce the scope of the
│ plan using the -target option.
```

# 5. However if we remove the ec2 instance resource block itself!!! the ec2 instance reousrce will be deleted!!!
```
data "aws_ami" "latest_ubuntu_image" {
    owners = ["amazon"]
    most_recent = true

    filter {
        name = "name"
        values = ["*al*"]
    }
}
```

```
Plan: 0 to add, 0 to change, 1 to destroy.
aws_instance.app: Destroying... [id=i-072818f7c1caa895a]
aws_instance.app: Still destroying... [id=i-072818f7c1caa895a, 00m10s elapsed]
aws_instance.app: Still destroying... [id=i-072818f7c1caa895a, 00m20s elapsed]
aws_instance.app: Still destroying... [id=i-072818f7c1caa895a, 00m30s elapsed]
aws_instance.app: Still destroying... [id=i-072818f7c1caa895a, 00m40s elapsed]
aws_instance.app: Still destroying... [id=i-072818f7c1caa895a, 00m50s elapsed]
aws_instance.app: Destruction complete after 50s

Destroy complete! Resources: 1 destroyed.
```
