# FOr each 

## 1. Suppose we want to create 5 resource of AWS iam user
```
resource "aws_iam_user" "alice" {
    name = "alice"
}

resource "aws_iam_user" "bob" {
    name = "bob"
}

resource "aws_iam_user" "charlie" {
    name = "charlie"
}


resource "aws_iam_user" "donny" {
    name = "donny"
}

resource "aws_iam_user" "ebella" {
    name = "ebella"
}

```

## 2. THis is not a good approach since we are manually adding it multiple times

## 3. We can make use of for each block for this use case
> for_each can be used when we want to create resource such that there is minor changes
> If we are ccreating identical resource we can use count
```
variable "users" {
    type = set(string)
    default = ["Alice", "Bob", "Charlie"]
}

resource "aws_iam_user" "devs" {
    for_each = var.users
    name = each.value
}

```

```
$ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.devs["Alice"] will be created
  + resource "aws_iam_user" "devs" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "Alice"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.devs["Bob"] will be created
  + resource "aws_iam_user" "devs" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "Bob"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.devs["Charlie"] will be created
  + resource "aws_iam_user" "devs" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "Charlie"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.
aws_iam_user.devs["Bob"]: Creating...
aws_iam_user.devs["Alice"]: Creating...
aws_iam_user.devs["Charlie"]: Creating...
aws_iam_user.devs["Alice"]: Creation complete after 1s [id=Alice]
aws_iam_user.devs["Bob"]: Creation complete after 1s [id=Bob]
aws_iam_user.devs["Charlie"]: Creation complete after 1s [id=Charlie]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

### If we use each.key , It is saame value as each.value
```

variable "users" {
    type = set(string)
    default = ["Alice", "Bob", "Charlie"]
}

resource "aws_iam_user" "devs" {
    for_each = var.users
    name = each.value
    tags = {
        env = each.key
    }
}
```
```
$ terraform plan                 

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.devs["Alice"] will be created
  + resource "aws_iam_user" "devs" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "Alice"
      + path          = "/"
      + tags          = {
          + "env" = "Alice"
        }
      + tags_all      = {
          + "env" = "Alice"
        }
      + unique_id     = (known after apply)
    }

  # aws_iam_user.devs["Bob"] will be created
  + resource "aws_iam_user" "devs" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "Bob"
      + path          = "/"
      + tags          = {
          + "env" = "Bob"
        }
      + tags_all      = {
          + "env" = "Bob"
        }
      + unique_id     = (known after apply)
    }

  # aws_iam_user.devs["Charlie"] will be created
  + resource "aws_iam_user" "devs" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "Charlie"
      + path          = "/"
      + tags          = {
          + "env" = "Charlie"
        }
      + tags_all      = {
          + "env" = "Charlie"
        }
      + unique_id     = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
$ 
```

## 4.We can also make use of map of string for the same purpose
```
variable "users" {
    type = map
    default = {
        dev = "Alice"
        support = "Bob"
        qa = "Charlie"
    }
}

resource "aws_iam_user" "devs" {
    for_each = var.users
    name = each.value
    tags = {
        role = each.key
    }
}

```

```
$ terraform plan

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.devs["dev"] will be created
  + resource "aws_iam_user" "devs" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "Alice"
      + path          = "/"
      + tags          = {
          + "role" = "dev"
        }
      + tags_all      = {
          + "role" = "dev"
        }
      + unique_id     = (known after apply)
    }

  # aws_iam_user.devs["qa"] will be created
  + resource "aws_iam_user" "devs" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "Charlie"
      + path          = "/"
      + tags          = {
          + "role" = "qa"
        }
      + tags_all      = {
          + "role" = "qa"
        }
      + unique_id     = (known after apply)
    }

  # aws_iam_user.devs["support"] will be created
  + resource "aws_iam_user" "devs" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "Bob"
      + path          = "/"
      + tags          = {
          + "role" = "support"
        }
      + tags_all      = {
          + "role" = "support"
        }
      + unique_id     = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────

```


