# Data type in Terraform 

Let us consider 2 data types
1) "Hello World" - string
2) 76453 - number

# 1 Let us create an iam user in terraform 
user with name userx will be created here
```
provider "aws" {
  region = "ap-south-2"
}

resource "aws_iam_user" "userx" {
  name = "userx"
}
```

```
$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.userx will be created
  + resource "aws_iam_user" "userx" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "userx"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

# 2 Assume that we want to restrict the username to just contain number and not strings. i.e 12345, 76764532. EmployeeID. Then we can use variables to  achieve this
Currently we have not specified the type of variable and hence it will accept string or number
```
provider "aws" {
  region = "ap-south-2"
}

variable "iam_username" {}

resource "aws_iam_user" "userx" {
  name = var.iam_username
}
```

```
$ terraform plan
var.iam_username
  Enter a value: userx


Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.userx will be created
  + resource "aws_iam_user" "userx" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "userx"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

```

# 3 Now if we specify the type as number, All string will be rejected
```
$ cat main.tf 
provider "aws" {
  region = "ap-south-2"
}

variable "iam_username" {
  type = number
}

resource "aws_iam_user" "userx" {
  name = var.iam_username
}                                                                                            
```

 ```
$ terraform plan
var.iam_username
  Enter a value: userx


Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Invalid value for input variable
│ 
│   on 7_vdf.tf line 5:
│    5: variable "iam_username" {
│ 
│ Unsuitable value for var.iam_username set using an interactive prompt: a number is
│ required.
╵
```

```
$ terraform plan
var.iam_username
  Enter a value: 55332


Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.userx will be created
  + resource "aws_iam_user" "userx" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "55332"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

```


# 4 Same will be rejected for default, we can ensure the correct type of variable is passed to the variable using type

```
$ cat 7_vdf.tf 
provider "aws" {
  region = "ap-south-2"
}

variable "iam_username" {
  type = number
  default = "userx"
}

resource "aws_iam_user" "userx" {
  name = var.iam_username
}
```

```
$ terraform plan 
╷
│ Error: Invalid default value for variable
│ 
│   on 7_vdf.tf line 7, in variable "iam_username":
│    7:   default = "userx"
│ 
│ This default value is not compatible with the variable's type constraint: a number is
│ required.
╵
```
