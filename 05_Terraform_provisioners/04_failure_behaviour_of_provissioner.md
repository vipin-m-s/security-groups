# Failure behaviour

- By default when provisioner fails, The resource is marked as tained and upon next apply, the resource will be replaced.
- We can override this behaviour using on_failure setting.
- We might have some scenario when we want to continue  resource creatio when the failure occur.


## on_failure = error
- This is default behaviour
- When provisioner failue occurs, apply will also fail
- Mark the resource as tained
- Replace the resource on next apply

```
resource "aws_iam_user" "user1" {
    name = "test1"

    provisioner "local-exec" {
        command = "creation time provisioner"
        on_failure = fail
    }
}

```

```
$ terraform apply -auto-approve  

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.user1 will be created
  + resource "aws_iam_user" "user1" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "test1"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_iam_user.user1: Creating...
aws_iam_user.user1: Provisioning with 'local-exec'...
aws_iam_user.user1 (local-exec): Executing: ["/bin/sh" "-c" "creation time provisioner"]
aws_iam_user.user1 (local-exec): /bin/sh: creation: command not found
╷
│ Error: local-exec provisioner error
│ 
│   with aws_iam_user.user1,
│   on main.tf line 4, in resource "aws_iam_user" "user1":
│    4:     provisioner "local-exec" {
│ 
│ Error running command 'creation time provisioner': exit status 127. Output: /bin/sh: creation:
│ command not found
│ 
╵
```

```
      "instances": [
        {
          "status": "tainted",
          "schema_version": 0,
```

## on_failure = continue
- We can also direct terraform to continue upon provisioner fail
- The apply will succeed ignoring provisioner failures
- The resource is not marked as tainted
- The Resource will not be replaced on next apply

```
resource "aws_iam_user" "user1" {
    name = "test1"

    provisioner "local-exec" {
        command = "creation time provisioner"
        on_failure = continue
    }
}
```
Apply succeeded
```
$ terraform apply -auto-approve  

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user.user1 will be created
  + resource "aws_iam_user" "user1" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "test1"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_iam_user.user1: Creating...
aws_iam_user.user1: Provisioning with 'local-exec'...
aws_iam_user.user1 (local-exec): Executing: ["/bin/sh" "-c" "creation time provisioner"]
aws_iam_user.user1 (local-exec): /bin/sh: creation: command not found
aws_iam_user.user1: Creation complete after 2s [id=test1]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

no taint in .tfstate file
```
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:iam::707264480025:user/test1",
            "force_destroy": false,
```

Resource did not recreate on apply
```
$ terraform apply -auto-approve
aws_iam_user.user1: Refreshing state... [id=test1]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences,
so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
$ 
```
