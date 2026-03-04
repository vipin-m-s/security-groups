# Functions

There are many built in functions such as max, file etc
We cannot create user defined functions in terraform 

# Max

max(10,20,30) 

# file

```
$ cat main.tf
resource "aws_iam_user" "dev_user_1" {
  name = "dev_user_1"
}

resource "aws_iam_user_policy" "allow_ec2_eip" {
  name = "allow_ec2_eip"
  user = aws_iam_user.dev_user_1.name
  policy = file("./policy.json")
}
```

```
$ cat policy.json
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "ec2:*",
        "Effect": "Allow",
        "Resource": "*"
      }, 
      { 
        "Action": "elasticloadbalancing:*",
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
}   
```
