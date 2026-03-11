# Destory.md 

- When we no longer need the resources we can destory it using terraform destroy command

## 1. Destroy all resources
If we execute terraform destory it will destroy all the resources
created by terraform 

## 2. Destory a specific resource

### a. Using -target
If we want to destory a specific resource we can use -target option 
This will delete only the aws_instance.webapp. 

`terraform destory -target=aws_instance.webapp`

However if we again run `terraform plan` we can see terraform will create the resource back
As the resource exists in config files

We need to remove the resource from config file or comment it
```
/*
resource aws_instance webapp {
  ami = "ami123"
  instance_type = "t3.micro"
}
*/
```

### b. By commenting the resource in config file
We can destroy a resource by commenting or removing from the config file
and then perform `terraform apply`
This will delete the resource

```
/*
resource aws_instance webapp {
  ami = "ami123"
  instance_type = "t3.micro"
}
*/
```
