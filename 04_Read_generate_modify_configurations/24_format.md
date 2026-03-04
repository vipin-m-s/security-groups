# FORMAT

# terraform fmt

Terraform fmt command will format the terraform files to follow a standard. Because each persons typing style is different. 
By performing format a same standard is followewd

```
$ cat main.tf 
resource "aws_instance" "webapp" {
        ami           = "ami-123"
  instance_type = "t3.micro"
}
```
```                                                                                      
$ terraform fmt
main.tf
```

Formatting will show  us the file where format was applied
```
$ cat main.tf 
resource "aws_instance" "webapp" {
  ami           = "ami-123"
  instance_type = "t3.micro"
}%  
```


# terraform fmt -diff
Regular terraform fmt will just print the files where formatting occured. But it will not display what changes has occured. 
With -diff we can view what are the changes occured. Thois command will change files !

```
$ cat main.tf 
resource "aws_instance" "webapp" {
          ami           = "ami-123"
  instance_type = "t3.micro"
}
```
```
$ terraform fmt -diff
main.tf
--- old/main.tf
+++ new/main.tf
@@ -1,4 +1,4 @@
 resource "aws_instance" "webapp" {
-          ami           = "ami-123"
+  ami           = "ami-123"
   instance_type = "t3.micro"
 }
\ No newline at end of file
```
```
$ cat main.tf 
resource "aws_instance" "webapp" {
  ami           = "ami-123"
  instance_type = "t3.micro"
}      
```

# terraform fmt -recursive

By default terraform wont perform recursive formatting, Only files in the same foler will be formatted.

```
$ cat main.tf 
resource "aws_instance" "webapp" {
          ami           = "ami-123"
  instance_type = "t3.micro"
}
```
```                                                                                      
$ cat test_folder/mian.tf 
resource "aws_instance" "webapp" {
          ami           = "ami-123"
  instance_type = "t3.micro"
}                                                                                      
``` 
```
$ terraform fmt
main.tf
```
```
$ cat main.tf 
resource "aws_instance" "webapp" {
  ami           = "ami-123"
  instance_type = "t3.micro"
}
```
```                                                                                      
$ cat test_folder/mian.tf 
resource "aws_instance" "webapp" {
          ami           = "ami-123"
  instance_type = "t3.micro"
}                                                                                      
```
``` 
$ terraform fmt -recursive
test_folder/mian.tf
```
```
$ cat test_folder/mian.tf 
resource "aws_instance" "webapp" {
  ami           = "ami-123"
  instance_type = "t3.micro"
}                                                                                      
``` 
```
