# Pointers

## 1. Provisioner works with any resource type, it does not have to associated only with aws_instance
```
resource "aws_iam_user" "user1" {
    name = "test1"

    provisioner "local-exec" {
        command = "echo local exec from iam user"    
    }
}
```
## 2. We can have multiple provisioner blocks within each resource block

```
resource "aws_iam_user" "user1" {
    name = "test1"

    provisioner "local-exec" {
        command = "echo local exec from iam user"
    }

    provisioner "local-exec" {
        command = "echo local exec 2 from iam user"
    }

    provisioner "local-exec" {
        command = "echo local exec 3 from iam user"
    }

}
```
