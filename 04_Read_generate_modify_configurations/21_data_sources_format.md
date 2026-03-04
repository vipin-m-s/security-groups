# Data sources format


# When we want to find the details of a ec2 instance using tags, We can use data source block

```
resource "aws_instance" "webapp" {
  ami = "ami-090b9c8aa1c84aefc"
  instance_type = "t3.micro"
  count = 2

  tags = {
    Name = "webapp-${count.index}"
    Env = count.index == 0 ? "Staging" : "Production"
  }
```
<img width="1623" height="699" alt="Screenshot 2026-03-02 at 4 02 32 PM" src="https://github.com/user-attachments/assets/23834bcd-4302-4873-89a4-d971ecbdcf2b" />

# Inorder to fetch the details of ec2 instance. We can use aws_instance
```
data "aws_instance" "webapp" {}
```
```
$ terraform apply -auto-approve
data.aws_instance.webapp: Reading...
aws_instance.webapp[1]: Refreshing state... [id=i-0a315c31c05c8bb03]
aws_instance.webapp[0]: Refreshing state... [id=i-09b796ef0bf8a215f]

Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: multiple EC2 Instances matched; use additional constraints to reduce matches to a single EC2 Instance
│ 
│   with data.aws_instance.webapp,
│   on main.tf line 12, in data "aws_instance" "webapp":
│   12: data "aws_instance" "webapp" {}
│ 
╵
$ 
```

# We can only match 1 instance with aws_instance. TO mathc many we can use aws_instances. But it has only limited attributes. 
We can use filters

```
$ cat main.tf                  
resource "aws_instance" "webapp" {
  ami = "ami-090b9c8aa1c84aefc"
  instance_type = "t3.micro"
  count = 2

  tags = {
    Name = "webapp-${count.index}"
    Env = count.index == 0 ? "Staging" : "Production"
  }
}

data "aws_instance" "webapp" {
  filter {
    name = "tag:Env"
    value = ["Production"]
  }
}%

```
```
$ terraform apply -auto-approve
data.aws_instance.webapp: Reading...
aws_instance.webapp[1]: Refreshing state... [id=i-0a315c31c05c8bb03]
aws_instance.webapp[0]: Refreshing state... [id=i-09b796ef0bf8a215f]
data.aws_instance.webapp: Read complete after 2s [id=i-0a315c31c05c8bb03]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no
differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
$ 
```
```
  {
      "mode": "data",
      "type": "aws_instance",
      "name": "webapp",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "ami": "ami-090b9c8aa1c84aefc",
            "arn": "arn:aws:ec2:ap-south-2:707264480025:instance/i-0a315c31c05c8bb03",
            "associate_public_ip_address": true,
            "availability_zone": "ap-south-2a",
            "credit_specification": [
              {
                "cpu_credits": "unlimited"
              }
            ],
            "disable_api_stop": false,
            "disable_api_termination": false,
            "ebs_block_device": [],
            "ebs_optimized": false,
            "enclave_options": [
              {
                "enabled": false
              }
            ],
            "ephemeral_block_device": [],
            "filter": [
              {
                "name": "tag:Env",
                "values": [
                  "Production"
                ]
              }
            ],
            "get_password_data": false,
            "get_user_data": false,
            "host_id": "",
            "host_resource_group_arn": "",
            "iam_instance_profile": "",
            "id": "i-0a315c31c05c8bb03",
            "instance_id": null,
            "instance_state": "running",
            "instance_tags": null,
            "instance_type": "t3.micro",
            "ipv6_addresses": [],
            "key_name": "",
            "launch_time": "2026-03-02T10:32:04Z",
            "maintenance_options": [
              {
                "auto_recovery": "default"
              }
            ],
            "metadata_options": [
              {
                "http_endpoint": "enabled",
                "http_protocol_ipv6": "disabled",
                "http_put_response_hop_limit": 2,
                "http_tokens": "required",
                "instance_metadata_tags": "disabled"
              }
            ],
            "monitoring": false,

```
