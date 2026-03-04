# resource dependency

Suppose we have a requirement where an externel storage has to be created before an instance can be initialized.
In Such cases terraform cannot gurantee the order in which resources are created. 
Some time it might create ec2 instance then s3, 
Whereas in other cases s3 then ec2.

# 1. Create s3 and then ec2
```
resource "aws_s3_bucet" "s3" {
    name = "my-s3-2026-bucekt-vips"
}

resource "aws_instance" "app" {
    ami = "ami-0035bcd3cad6883a6"
    instance_type = "t3.micro"
}
```

# 2. Order or creation is not guaranteed. 
Here s3 and ec2 both are creating at the same time, Which is wrong
```
Plan: 2 to add, 0 to change, 0 to destroy.
aws_s3_bucket.s3: Creating...
aws_instance.app: Creating...
aws_s3_bucket.s3: Creation complete after 2s [id=my-s3-2026-bucekt-vips]
```

# 3. Add a dependency , this will ensure s3 bucket will be created first then only ec2 will be created
```
resource "aws_s3_bucket" "s3" {
    bucket = "my-s3-2026-bucekt-vips"
}

resource "aws_instance" "app" {
    ami = "ami-0035bcd3cad6883a6"
    instance_type = "t3.micro"
    depends_on = [aws_s3_bucket.s3]
}
```

We can see s3 got created first then only ec2 is getting created. Both will not be created at the same time
```
Plan: 2 to add, 0 to change, 0 to destroy.
aws_s3_bucket.s3: Creating...
aws_s3_bucket.s3: Creation complete after 2s [id=my-s3-2026-bucekt-vips]
aws_instance.app: Creating...
aws_instance.app: Still creating... [00m10s elapsed]
aws_instance.app: Creation complete after 13s [id=i-0636b5cea96fe70ab]

```
# 4. During deletion the dependency is reversed. The ec2 is deleted first and then the S3
First ec2 will be destroyed and then onyl s3 is destroyed
```
Plan: 0 to add, 0 to change, 2 to destroy.
aws_instance.app: Destroying... [id=i-0636b5cea96fe70ab]
aws_instance.app: Still destroying... [id=i-0636b5cea96fe70ab, 00m10s elapsed]
aws_instance.app: Still destroying... [id=i-0636b5cea96fe70ab, 00m20s elapsed]
aws_instance.app: Still destroying... [id=i-0636b5cea96fe70ab, 00m30s elapsed]
aws_instance.app: Still destroying... [id=i-0636b5cea96fe70ab, 00m40s elapsed]
aws_instance.app: Still destroying... [id=i-0636b5cea96fe70ab, 00m50s elapsed]
aws_instance.app: Destruction complete after 51s
aws_s3_bucket.s3: Destroying... [id=my-s3-2026-bucekt-vips]
aws_s3_bucket.s3: Destruction complete after 0s

Destroy complete! Resources: 2 destroyed.
```
