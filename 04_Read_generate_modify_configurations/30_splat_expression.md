# Splat expression 

When we want to extract some information about the created resources we can use splat expressions

```
$ cat one.tf 
resource "aws_iam_user" "dev-users" {
  name = "dev-user-${count.index}"
  count = 3
}

output "dev_iam_users_arns" {
  value = aws_iam_user.dev-users[0].arn
}
```
```                                                                                
$ terraform apply -replace="aws_instance.app"
aws_iam_user.dev-users[0]: Refreshing state... [id=dev-user-0]
aws_iam_user.dev-users[2]: Refreshing state... [id=dev-user-2]
aws_iam_user.dev-users[1]: Refreshing state... [id=dev-user-1]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

dev_iam_users_arns = "arn:aws:iam::707264480025:user/dev-user-0"
```
```
$ cat one.tf 
resource "aws_iam_user" "dev-users" {
  name = "dev-user-${count.index}"
  count = 3
}

output "dev_iam_users_arns" {
  value = aws_iam_user.dev-users[*].arn
}
```
```                                                                                
$ terraform apply -replace="aws_instance.app"
aws_iam_user.dev-users[2]: Refreshing state... [id=dev-user-2]
aws_iam_user.dev-users[1]: Refreshing state... [id=dev-user-1]
aws_iam_user.dev-users[0]: Refreshing state... [id=dev-user-0]

Changes to Outputs:
  ~ dev_iam_users_arns = "arn:aws:iam::707264480025:user/dev-user-0" -> [
      + "arn:aws:iam::707264480025:user/dev-user-0",
      + "arn:aws:iam::707264480025:user/dev-user-1",
      + "arn:aws:iam::707264480025:user/dev-user-2",
    ]

You can apply this plan to save these new output values to the Terraform state,
without changing any real infrastructure.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

dev_iam_users_arns = [
  "arn:aws:iam::707264480025:user/dev-user-0",
  "arn:aws:iam::707264480025:user/dev-user-1",
  "arn:aws:iam::707264480025:user/dev-user-2",
]
```
