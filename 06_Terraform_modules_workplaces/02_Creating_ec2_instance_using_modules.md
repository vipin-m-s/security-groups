# 02_Creating_ec2_instance_using_modules 

We can reuse existing module to create ec2 instance, security group and rules.

```
module "ec-instance" {
    source = "terraform-aws-modules/ec2-instance/aws"
    version = "6.3.0"
}
```

Terraform init will download the .tf files related to terraform modules
in .terraform/modules folder


```
➜  terraform terraform init
Initializing the backend...
Initializing modules...
Downloading registry.terraform.io/terraform-aws-modules/ec2-instance/aws 6.3.0 for ec-instance...
- ec-instance in .terraform/modules/ec-instance
Initializing provider plugins...
- Finding hashicorp/aws versions matching ">= 6.28.0"...
- Installing hashicorp/aws v6.35.1...
- Installed hashicorp/aws v6.35.1 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
➜  terraform 
```

```
➜  terraform terraform validate
Success! The configuration is valid.
```

```
➜  terraform terraform plan    
module.ec-instance.data.aws_ssm_parameter.this: Reading...
module.ec-instance.data.aws_subnet.this[0]: Reading...
module.ec-instance.data.aws_partition.current: Reading...
module.ec-instance.data.aws_partition.current: Read complete after 0s [id=aws]
module.ec-instance.data.aws_ssm_parameter.this: Read complete after 0s [id=/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64]

Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: multiple EC2 Subnets matched; use additional constraints to reduce matches to a single EC2 Subnet
│ 
│   with module.ec-instance.data.aws_subnet.this[0],
│   on .terraform/modules/ec-instance/main.tf line 745, in data "aws_subnet" "this":
│  745: data "aws_subnet" "this" {
│ 
╵
```

subnet_id is required for this module
```
module "ec-instance" {
    source = "terraform-aws-modules/ec2-instance/aws"
    version = "6.3.0"
    subnet_id     = "subnet-0a87fd997b93f35c2"
}
```

```

```
