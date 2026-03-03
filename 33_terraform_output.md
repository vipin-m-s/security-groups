# Output

We can view the output of the infra setup using output block.
terraform output can be used to print any details from the terraform state file

```
resource "aws_iam_user" "dev-users" {
    count = 3
    name = "dev-${count.index}"
}

output "iam_arns" {
    value = aws_iam_user.dev-users[*].arn
}

output "iam_users" {
    value = aws_iam_user.dev-users[*].name
}
```

```
$ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.dev-users[0] will be created
  + resource "aws_iam_user" "dev-users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "dev-0"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.dev-users[1] will be created
  + resource "aws_iam_user" "dev-users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "dev-1"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # aws_iam_user.dev-users[2] will be created
  + resource "aws_iam_user" "dev-users" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "dev-2"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + iam_arns  = [
      + (known after apply),
      + (known after apply),
      + (known after apply),
    ]
  + iam_users = [
      + "dev-0",
      + "dev-1",
      + "dev-2",
    ]
aws_iam_user.dev-users[0]: Creating...
aws_iam_user.dev-users[1]: Creating...
aws_iam_user.dev-users[2]: Creating...
aws_iam_user.dev-users[1]: Creation complete after 2s [id=dev-1]
aws_iam_user.dev-users[0]: Creation complete after 2s [id=dev-0]
aws_iam_user.dev-users[2]: Creation complete after 2s [id=dev-2]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

iam_arns = [
  "arn:aws:iam::707264480025:user/dev-0",
  "arn:aws:iam::707264480025:user/dev-1",
  "arn:aws:iam::707264480025:user/dev-2",
]
iam_users = [
  "dev-0",
  "dev-1",
  "dev-2",
]
```

# terraform.tfstate
```
{
  "version": 4,
  "terraform_version": "1.14.6",
  "serial": 2,
  "lineage": "31e76038-dc99-76da-7e38-cc522d86a4f4",
  "outputs": {
    "iam_arns": {
      "value": [
        "arn:aws:iam::707264480025:user/dev-0",
        "arn:aws:iam::707264480025:user/dev-1",
        "arn:aws:iam::707264480025:user/dev-2"
      ],
      "type": [
        "tuple",
        [
          "string",
          "string",
          "string"
        ]
      ]
    },
    "iam_users": {
      "value": [
        "dev-0",
        "dev-1",
        "dev-2"
      ],
      "type": [
        "tuple",
        [
          "string",
          "string",
          "string"
        ]
      ]
    }
  },
```

# command

```$ terraform output iam_arns
[
  "arn:aws:iam::707264480025:user/dev-0",
  "arn:aws:iam::707264480025:user/dev-1",
  "arn:aws:iam::707264480025:user/dev-2",
]
$ terraform output iam_users
[
  "dev-0",
  "dev-1",
  "dev-2",
]
```
