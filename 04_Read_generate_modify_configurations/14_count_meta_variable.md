# Count

# WHen creating multiple resources using count. We can create multiple ec2 instances

```
resource "aws_instance" "webserver" {
  ami = "ami-00e42015cc6980619"
  instance_type = "t3.micro"
  count = 3
}
```

<img width="1608" height="262" alt="Screenshot 2026-03-02 at 10 09 49 AM" src="https://github.com/user-attachments/assets/b95086fe-5dc8-417b-84b5-119111dbd651" />

# If we wanted to customize some values for each of the instance it is not possible 

For example, adding a Name for each of the instance
```
resource "aws_instance" "webserver" {
  ami = "ami-00e42015cc6980619"
  instance_type = "t3.micro"
  count = 3
  tags = {
    Name = "payments-server"
  }
}
```

ALl instances are created with same name

<img width="1618" height="221" alt="Screenshot 2026-03-02 at 10 15 07 AM" src="https://github.com/user-attachments/assets/c02d0d4b-84c9-467b-b99e-f1d2dff8180d" />



# When creating iam users using count variable , It will fail since each iam user should be uniuq

```
resource "aws_iam_user" "users" {
  name = "payments"
  count = 3
}
```
```
$ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.users[0] will be created
  + resource "aws_iam_user" "users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "payments"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.users[1] will be created
  + resource "aws_iam_user" "users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "payments"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.users[2] will be created
  + resource "aws_iam_user" "users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "payments"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.
aws_iam_user.users[1]: Creating...
aws_iam_user.users[0]: Creating...
aws_iam_user.users[2]: Creating...
aws_iam_user.users[0]: Creation complete after 1s [id=payments]
╷
│ Error: creating IAM User (payments): operation error IAM: CreateUser, https response error StatusCode: 409, RequestID: 5a4fd4b7-388d-4aec-90b2-7ee88024da67, EntityAlreadyExists: User with name payments already exists.
│ 
│   with aws_iam_user.users[2],
│   on main.tf line 1, in resource "aws_iam_user" "users":
│    1: resource "aws_iam_user" "users" {
│ 
╵
╷
│ Error: creating IAM User (payments): operation error IAM: CreateUser, https response error StatusCode: 409, RequestID: 54030e8a-fa24-4466-9dbc-6c86899f1225, EntityAlreadyExists: User with name payments already exists.
│ 
│   with aws_iam_user.users[1],
│   on main.tf line 1, in resource "aws_iam_user" "users":
│    1: resource "aws_iam_user" "users" {
│ 
╵

```


# count.index
Indexing of the count starts with 0,1,2 etc
We can view that in plan and apply commands as well

```
  # aws_instance.webserver[2] will be created
  + resource "aws_instance" "webserver" {
      + ami                                  = "ami-00e42015cc6980619"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
```

```
resource "aws_instance" "webserver" {
  ami = "ami-00e42015cc6980619"
  instance_type = "t3.micro"
  count = 3
  
  tags = {
    Name = "payments-server-${count.index}"
  }
}
```
<img width="1622" height="221" alt="Screenshot 2026-03-02 at 10 17 28 AM" src="https://github.com/user-attachments/assets/05dde05a-5abe-43e1-ad39-d6a2012c491c" />



```
$ cat main.tf                    
resource "aws_iam_user" "users" {
  name = "payment-user=${count.index}"
  count = 3
}%

```

```
$ terraform plan

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.users[0] will be created
  + resource "aws_iam_user" "users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "payment-user-0"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.users[1] will be created
  + resource "aws_iam_user" "users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "payment-user-1"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.users[2] will be created
  + resource "aws_iam_user" "users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "payment-user-2"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.
```

```
$ terraform apply -auto-approve  

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.users[0] will be created
  + resource "aws_iam_user" "users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "payment-user-0"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.users[1] will be created
  + resource "aws_iam_user" "users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "payment-user-1"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.users[2] will be created
  + resource "aws_iam_user" "users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "payment-user-2"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.
aws_iam_user.users[0]: Creating...
aws_iam_user.users[1]: Creating...
aws_iam_user.users[2]: Creating...
aws_iam_user.users[0]: Creation complete after 1s [id=payment-user-0]
aws_iam_user.users[2]: Creation complete after 1s [id=payment-user-2]
aws_iam_user.users[1]: Creation complete after 1s [id=payment-user-1]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
$
```

<img width="1539" height="129" alt="Screenshot 2026-03-02 at 10 20 42 AM" src="https://github.com/user-attachments/assets/f3404996-83cf-49cd-b4ef-b87226433877" />


# Complex indexing

When we dont want to use 0,1,2 etc we can use list and list index for name of the resources
```
$ cat main.tf 
variable "users" {
  type = list(string)
  default = ["Alice", "Bob", "Charlie"]
}

resource "aws_iam_user" "users" {
  name = var.users[count.index]
  count = 3
}%
```

```                                                             
$ terraform apply -auto-approve  

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

   aws_iam_user.users[0] will be created
  + resource "aws_iam_user" "users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "Alice"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

   aws_iam_user.users[1] will be created
  + resource "aws_iam_user" "users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "Bob"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

   aws_iam_user.users[2] will be created
  + resource "aws_iam_user" "users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "Charlie"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.
aws_iam_user.users[2]: Creating...
aws_iam_user.users[0]: Creating...
aws_iam_user.users[1]: Creating...
aws_iam_user.users[2]: Creation complete after 1s [id=Charlie]
aws_iam_user.users[0]: Creation complete after 1s [id=Alice]
aws_iam_user.users[1]: Creation complete after 1s [id=Bob]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```


<img width="1544" height="173" alt="Screenshot 2026-03-02 at 10 28 10 AM" src="https://github.com/user-attachments/assets/cae2d7a8-cb69-42d7-9097-1706234dc173" />



