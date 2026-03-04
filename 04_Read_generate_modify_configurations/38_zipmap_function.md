# zipmap 
zipmap function allows us to create maps using 2 separate lists.
1 list will be used as key and other as value

zipmap(key_list, value_lsit)
zipmap(["a","b"], [1,2])
{
  "a" = 1
  "b" = 2
}

```
$ cat main.tf 
resource "aws_iam_user" "devs" {
    name = "dev_${count.index}"
    count =3
}

output "iam_users" {
    value = aws_iam_user.devs[*].name
}


output "iam_arns" {
    value = aws_iam_user.devs[*].arn 
}


Outputs:

iam_arns = [
  "arn:aws:iam::707264480025:user/dev_0",
  "arn:aws:iam::707264480025:user/dev_1",
  "arn:aws:iam::707264480025:user/dev_2",
]
iam_users = [
  "dev_0",
  "dev_1",
  "dev_2",
]


$ cat main.tf
resource "aws_iam_user" "devs" {
    name = "dev_${count.index}"
    count =3
}
output "combined" {
    value = zipmap(aws_iam_user.devs[*].name, aws_iam_user.devs[*].arn)
}%


Outputs:

combined = {
  "dev_0" = "arn:aws:iam::707264480025:user/dev_0"
  "dev_1" = "arn:aws:iam::707264480025:user/dev_1"
  "dev_2" = "arn:aws:iam::707264480025:user/dev_2"
}
```

