  # Creation/Deletion time provisioners

  ## 1. Creation time provisioners
  - By default the local-exec and remote-exec proviioners are creation time provisioners. 
  - They will execute only after resource is created. 
  - They will not execute during deleetion or updation of resource

```
resource "aws_iam_user" "user1" {
    name = "test1"

    provisioner "local-exec" {
        command = "echo local exec from iam user"
    }

}
```

```
Plan: 1 to add, 0 to change, 0 to destroy.
aws_iam_user.user1: Creating...
aws_iam_user.user1: Provisioning with 'local-exec'...
aws_iam_user.user1 (local-exec): Executing: ["/bin/sh" "-c" "echo local exec from iam user"]
aws_iam_user.user1 (local-exec): local exec from iam user
aws_iam_user.user1: Creation complete after 1s [id=test1]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

## 2. Deletion time provisioners
- We can also make a provisioner to execute before it is destoryed.
- Just before resource is destoryed the local or remote exec will execute
- We need to add the when = destroy

```
resource "aws_iam_user" "user1" {
    name = "test1"

    provisioner "local-exec" {
        when = destroy
        command = "echo destory time provisioner"
    }

}
```

```
$ terraform destroy -auto-approve
aws_iam_user.user1: Refreshing state... [id=test1]

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_iam_user.user1 will be destroyed
  - resource "aws_iam_user" "user1" {
      - arn                  = "arn:aws:iam::707264480025:user/test1" -> null
      - force_destroy        = false -> null
      - id                   = "test1" -> null
      - name                 = "test1" -> null
      - path                 = "/" -> null
      - tags                 = {} -> null
      - tags_all             = {} -> null
      - unique_id            = "AIDA2JLB7QMM5MSVFBRIM" -> null
        # (1 unchanged attribute hidden)
    }

Plan: 0 to add, 0 to change, 1 to destroy.
aws_iam_user.user1: Destroying... [id=test1]
aws_iam_user.user1: Provisioning with 'local-exec'...
aws_iam_user.user1 (local-exec): Executing: ["/bin/sh" "-c" "echo destory time provisioner"]
aws_iam_user.user1 (local-exec): destory time provisioner
aws_iam_user.user1: Destruction complete after 2s
```

## Provisioner with both creation time and destory time provisioner
```
resource "aws_iam_user" "user1" {
    name = "test1"

    provisioner "local-exec" {
        command = "echo creation time provisioner"
    }

    provisioner "local-exec" {
        when = destroy
        command = "echo destory time provisioner"
    }

}
```

```
$ terraform apply -auto-approve  
....
Plan: 1 to add, 0 to change, 0 to destroy.
aws_iam_user.user1: Creating...
aws_iam_user.user1: Provisioning with 'local-exec'...
aws_iam_user.user1 (local-exec): Executing: ["/bin/sh" "-c" "echo creation time provisioner"]
aws_iam_user.user1 (local-exec): creation time provisioner
aws_iam_user.user1: Creation complete after 2s [id=test1]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

```
$ terraform destory -auto-approve  
....
Plan: 0 to add, 0 to change, 1 to destroy.
aws_iam_user.user1: Destroying... [id=test1]
aws_iam_user.user1: Provisioning with 'local-exec'...
aws_iam_user.user1 (local-exec): Executing: ["/bin/sh" "-c" "echo destory time provisioner"]
aws_iam_user.user1 (local-exec): destory time provisioner
aws_iam_user.user1: Destruction complete after 1s

Destroy complete! Resources: 1 destroyed.
```

# Tainted resource
- When a local proviser or remote provisioner fails to execute any command.
- The resource status is marked as tainted
- When we run the terraform apply next time, The resource would be deleted and recreated
- If provisioners fail, it means that the server is semi-configured state

```
resource "aws_iam_user" "user1" {
    name = "test1"

    provisioner "local-exec" {
        command = "creation time provisioner"
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
$ 
```

tf state file
```
      "instances": [
        {
          "status": "tainted",
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:iam::707264480025:user/test1",
            "force_destroy": false,
```

On next execution of apply, Its trying to delete and recreate the resource
```
$ terraform apply -auto-approve
aws_iam_user.user1: Refreshing state... [id=test1]

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_iam_user.user1 is tainted, so must be replaced
-/+ resource "aws_iam_user" "user1" {
      ~ arn                  = "arn:aws:iam::707264480025:user/test1" -> (known after apply)
      ~ id                   = "test1" -> (known after apply)
        name                 = "test1"
      - tags                 = {} -> null
      ~ tags_all             = {} -> (known after apply)
      ~ unique_id            = "AIDA2JLB7QMMWRSAOY3JE" -> (known after apply)
        # (3 unchanged attributes hidden)
    }

Plan: 1 to add, 0 to change, 1 to destroy.
```
