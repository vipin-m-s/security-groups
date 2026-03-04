# Count parameter issues

When we are creating resources using the count parameter, If we create iam users and if we later on add a new ussser at the beginning. 
Then every resource name is updated.

# 1. Create 3 iam users
```
variable "users" {
    default = ["user1", "user2", "user3"]
}

resource "aws_iam_user" "dev_users" {
    name = var.users[count.index]
    count = 3
}
```

WE can see 3 iam users will be created here
```
$ terraform plan

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.dev_users[0] will be created
  + resource "aws_iam_user" "dev_users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "user1"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.dev_users[1] will be created
  + resource "aws_iam_user" "dev_users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "user2"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.dev_users[2] will be created
  + resource "aws_iam_user" "dev_users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "user3"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
$ 
```

Users are also mainted at index_key 0,1,2 in tf state file
```
  "resources": [
    {
      "mode": "managed",
      "type": "aws_iam_user",
      "name": "dev_users",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:iam::707264480025:user/user1",
            "force_destroy": false,
            "id": "user1",
            "name": "user1",
            "path": "/",
            "permissions_boundary": "",
            "tags": null,
            "tags_all": {},
            "unique_id": "AIDA2JLB7QMMQ6GDO2KGK"
          },
          "sensitive_attributes": [],
          "identity_schema_version": 0,
          "private": "bnVsbA=="
        },
        {
          "index_key": 1,
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:iam::707264480025:user/user2",
            "force_destroy": false,
            "id": "user2",
            "name": "user2",
            "path": "/",
            "permissions_boundary": "",
            "tags": null,
            "tags_all": {},
            "unique_id": "AIDA2JLB7QMM575DR4NWO"
          },
          "sensitive_attributes": [],
          "identity_schema_version": 0,
          "private": "bnVsbA=="
        },
        {
          "index_key": 2,
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:iam::707264480025:user/user3",
            "force_destroy": false,
            "id": "user3",
            "name": "user3",
            "path": "/",
            "permissions_boundary": "",
            "tags": null,
            "tags_all": {},
            "unique_id": "AIDA2JLB7QMM7SBXOBVAP"
          },
          "sensitive_attributes": [],
          "identity_schema_version": 0,
          "private": "bnVsbA=="
        }
      ]
    }
  ],
  "check_results": null
}

```

# 2. Now lets assume we are adding 4th user at the end of the list
There will not be any problem, Since the index 3 is free. New resource is added at index 3
```
variable "users" {
    default = ["user1", "user2", "user3", "user4"]
}

resource "aws_iam_user" "dev_users" {
    name = var.users[count.index]
    count = 4
}

$ terraform plan               
aws_iam_user.dev_users[1]: Refreshing state... [id=user2]
aws_iam_user.dev_users[0]: Refreshing state... [id=user1]
aws_iam_user.dev_users[2]: Refreshing state... [id=user3]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.dev_users[3] will be created
  + resource "aws_iam_user" "dev_users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "user4"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
$ 

```

# 3. Now lets add a user at beginning
All the reosurce names are being updated. Which is wrong. 
```
variable "users" {
    default = ["user0", "user1", "user2", "user3", "user4"]
}

resource "aws_iam_user" "dev_users" {
    name = var.users[count.index]
    count = 5
}


$ terraform plan
aws_iam_user.dev_users[0]: Refreshing state... [id=user1]
aws_iam_user.dev_users[1]: Refreshing state... [id=user2]
aws_iam_user.dev_users[2]: Refreshing state... [id=user3]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create
  ~ update in-place

Terraform will perform the following actions:

  # aws_iam_user.dev_users[0] will be updated in-place
  ~ resource "aws_iam_user" "dev_users" {
        id                   = "user1"
      ~ name                 = "user1" -> "user0"
        tags                 = {}
        # (6 unchanged attributes hidden)
    }

  # aws_iam_user.dev_users[1] will be updated in-place
  ~ resource "aws_iam_user" "dev_users" {
        id                   = "user2"
      ~ name                 = "user2" -> "user1"
        tags                 = {}
        # (6 unchanged attributes hidden)
    }

  # aws_iam_user.dev_users[2] will be updated in-place
  ~ resource "aws_iam_user" "dev_users" {
        id                   = "user3"
      ~ name                 = "user3" -> "user2"
        tags                 = {}
        # (6 unchanged attributes hidden)
    }

  # aws_iam_user.dev_users[3] will be created
  + resource "aws_iam_user" "dev_users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "user3"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.dev_users[4] will be created
  + resource "aws_iam_user" "dev_users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "user4"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 2 to add, 3 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
```

# 4. Apply the change
We are thrown with error. Hence we should use count only when we are creating similar resources. and not differing resources.
```
$ terraform apply -auto-approve
aws_iam_user.dev_users[0]: Refreshing state... [id=user1]
aws_iam_user.dev_users[1]: Refreshing state... [id=user2]
aws_iam_user.dev_users[2]: Refreshing state... [id=user3]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create
  ~ update in-place

Terraform will perform the following actions:

  # aws_iam_user.dev_users[0] will be updated in-place
  ~ resource "aws_iam_user" "dev_users" {
        id                   = "user1"
      ~ name                 = "user1" -> "user0"
        tags                 = {}
        # (6 unchanged attributes hidden)
    }

  # aws_iam_user.dev_users[1] will be updated in-place
  ~ resource "aws_iam_user" "dev_users" {
        id                   = "user2"
      ~ name                 = "user2" -> "user1"
        tags                 = {}
        # (6 unchanged attributes hidden)
    }

  # aws_iam_user.dev_users[2] will be updated in-place
  ~ resource "aws_iam_user" "dev_users" {
        id                   = "user3"
      ~ name                 = "user3" -> "user2"
        tags                 = {}
        # (6 unchanged attributes hidden)
    }

  # aws_iam_user.dev_users[3] will be created
  + resource "aws_iam_user" "dev_users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "user3"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.dev_users[4] will be created
  + resource "aws_iam_user" "dev_users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "user4"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 2 to add, 3 to change, 0 to destroy.
aws_iam_user.dev_users[4]: Creating...
aws_iam_user.dev_users[3]: Creating...
aws_iam_user.dev_users[1]: Modifying... [id=user2]
aws_iam_user.dev_users[2]: Modifying... [id=user3]
aws_iam_user.dev_users[0]: Modifying... [id=user1]
aws_iam_user.dev_users[0]: Modifications complete after 1s [id=user0]
aws_iam_user.dev_users[4]: Creation complete after 1s [id=user4]
╷
│ Error: updating IAM User (user2): operation error IAM: UpdateUser, https response error StatusCode: 409, RequestID: 6574dc89-0116-4fa4-9154-e0d97c1a01c1, EntityAlreadyExists: User with name user1 already exists.
│ 
│   with aws_iam_user.dev_users[1],
│   on main.tf line 5, in resource "aws_iam_user" "dev_users":
│    5: resource "aws_iam_user" "dev_users" {
│ 
╵
╷
│ Error: creating IAM User (user3): operation error IAM: CreateUser, https response error StatusCode: 409, RequestID: 2efdb69b-6c55-41d6-ba00-13ea2a5c8a47, EntityAlreadyExists: User with name user3 already exists.
│ 
│   with aws_iam_user.dev_users[3],
│   on main.tf line 5, in resource "aws_iam_user" "dev_users":
│    5: resource "aws_iam_user" "dev_users" {
│ 
╵
╷
│ Error: updating IAM User (user3): operation error IAM: UpdateUser, https response error StatusCode: 409, RequestID: 8b2cec07-c1b6-4d18-b0af-69236b50af7b, EntityAlreadyExists: User with name user2 already exists.
│ 
│   with aws_iam_user.dev_users[2],
│   on main.tf line 5, in resource "aws_iam_user" "dev_users":
│    5: resource "aws_iam_user" "dev_users" {
│ 
╵
```


