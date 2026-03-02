# Load order

Terraform is going to load all the .tf and .tf.json files from the  current working directory and then perform plan/apply
Terraform will not select .tf and .tf.json files from subdirectory 
Terraform will internally merge all the .tf and .tf.json files and perform plan/apply
If there are any duplicate local resource name, Then terraform will throw errors.
Each .tf file should have unique local resource name,

```
$ cat one.tf
resource "aws_instance" "webapp" {
  ami           = "ami-123"
  instance_type = "t3.micro"
}%                                                                                      
$ cat two.tf 
resource "aws_instance" "webapp" {
  ami           = "ami-123"
  instance_type = "t3.micro"
}%                                                                                      
$ terraform plan
╷
│ Error: Duplicate resource "aws_instance" configuration
│ 
│   on two.tf line 1:
│    1: resource "aws_instance" "webapp" {
│ 
│ A aws_instance resource named "webapp" was already declared at one.tf:1,1-33.
│ Resource names must be unique per type in each module.
╵
$ 

```


```
$ tree
.
├── info_logs
├── one.tf
└── test
    └── two.tf

2 directories, 3 files

$ terraform plan

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.webapp will be created
  + resource "aws_instance" "webapp" {
      + ami                                  = "ami-123"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)



```
