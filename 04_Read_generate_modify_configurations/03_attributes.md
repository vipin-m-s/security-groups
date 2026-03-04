# Attributes

# WHat are attributes?
Each resource created via terraform will be stored in the state file
The state file will have attributes associated with the resource and their values stored in state file
ID -> instace id
IP -> public ip 
etc

# 1. Create eip and ec2
```
provider "aws" {
    region = "ap-south-2"
}

resource "aws_eip" "lb" {
    domain = "vpc"
}

resource "aws_instance" "webserver" {
    ami = "ami-00e42015cc6980619"
    instance_type = "t3.micro"
}
```

# 2. State file will be created
```
{
  "version": 4,
  "terraform_version": "1.14.6",
  "serial": 6,
  "lineage": "aff704d0-a7ee-d957-dbd0-eb83611f301c",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "aws_eip",
      "name": "lb",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "address": null,
            "allocation_id": "eipalloc-0edf4f8566e38c79e",
            "arn": "arn:aws:ec2:ap-south-2:707264480025:elastic-ip/eipalloc-0edf4f8566e38c79e",
            "associate_with_private_ip": null,
            "association_id": "",
            "carrier_ip": "",
            "customer_owned_ip": "",
            "customer_owned_ipv4_pool": "",
            "domain": "vpc",
            "id": "eipalloc-0edf4f8566e38c79e",
            "instance": "",
            "ipam_pool_id": null,
            "network_border_group": "ap-south-2",
            "network_interface": "",
            "private_dns": null,
            "private_ip": "",
            "ptr_record": "",
            "public_dns": "ec2-18-61-242-13.ap-south-2.compute.amazonaws.com",
            "public_ip": "18.61.242.13",
            "public_ipv4_pool": "amazon",
            "region": "ap-south-2",
            "tags": null,
            "tags_all": {},
            "timeouts": null
          },
          "sensitive_attributes": [],
          "identity_schema_version": 0,
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiZGVsZXRlIjoxODAwMDAwMDAwMDAsInJlYWQiOjkwMDAwMDAwMDAwMCwidXBkYXRlIjozMDAwMDAwMDAwMDB9fQ=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "webserver",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 2,
          "attributes": {
            "ami": "ami-00e42015cc6980619",
            "arn": "arn:aws:ec2:ap-south-2:707264480025:instance/i-0b8657b79ecce9dd3",
            "associate_public_ip_address": true,
            "availability_zone": "ap-south-2a",
            "capacity_reservation_specification": [
              {
                "capacity_reservation_preference": "open",
                "capacity_reservation_target": []
              }
            ],
            "cpu_options": [
              {
                "amd_sev_snp": "",
                "core_count": 1,
                "nested_virtualization": "",
                "threads_per_core": 2
              }
            ],
            "credit_specification": [
              {
                "cpu_credits": "unlimited"
              }
            ],
            "disable_api_stop": false,
            "disable_api_termination": false,
            "ebs_block_device": [],
            "ebs_optimized": false,
            "enable_primary_ipv6": null,
            "enclave_options": [
              {
                "enabled": false
              }
            ],
            "ephemeral_block_device": [],
            "force_destroy": false,
            "get_password_data": false,
            "hibernation": false,
            "host_id": "",
            "host_resource_group_arn": null,
            "iam_instance_profile": "",
            "id": "i-0b8657b79ecce9dd3",
            "instance_initiated_shutdown_behavior": "stop",
            "instance_lifecycle": "",
            "instance_market_options": [],
            "instance_state": "running",
            "instance_type": "t3.micro",
            "ipv6_address_count": 0,
            "ipv6_addresses": [],
            "key_name": "",
            "launch_template": [],
            "maintenance_options": [
              {
                "auto_recovery": "default"
              }
            ],
            "metadata_options": [
              {
                "http_endpoint": "enabled",
                "http_protocol_ipv6": "disabled",
                "http_put_response_hop_limit": 1,
                "http_tokens": "optional",
                "instance_metadata_tags": "disabled"
              }
            ],
            "monitoring": false,
            "network_interface": [],
            "outpost_arn": "",
            "password_data": "",
            "placement_group": "",
            "placement_group_id": "",
            "placement_partition_number": 0,
            "primary_network_interface": [
              {
                "delete_on_termination": true,
                "network_interface_id": "eni-03a84d958a2c6b5bb"
              }
            ],
            "primary_network_interface_id": "eni-03a84d958a2c6b5bb",
            "private_dns": "ip-172-31-12-74.ap-south-2.compute.internal",
            "private_dns_name_options": [
              {
                "enable_resource_name_dns_a_record": false,
                "enable_resource_name_dns_aaaa_record": false,
                "hostname_type": "ip-name"
              }
            ],
            "private_ip": "172.31.12.74",
            "public_dns": "ec2-18-60-227-229.ap-south-2.compute.amazonaws.com",
            "public_ip": "18.60.227.229",
            "region": "ap-south-2",
            "root_block_device": [
              {
                "delete_on_termination": true,
                "device_name": "/dev/sda1",
                "encrypted": false,
                "iops": 3000,
                "kms_key_id": "",
                "tags": {},
                "tags_all": {},
                "throughput": 125,
                "volume_id": "vol-08245222ee03e452e",
                "volume_size": 10,
                "volume_type": "gp3"
              }
            ],
            "secondary_network_interface": [],
            "secondary_private_ips": [],
            "security_groups": [
              "default"
            ],
            "source_dest_check": true,
            "spot_instance_request_id": "",
            "subnet_id": "subnet-0cfa1aa04c041aee0",
            "tags": null,
            "tags_all": {},
            "tenancy": "default",
            "timeouts": null,
            "user_data": null,
            "user_data_base64": null,
            "user_data_replace_on_change": false,
            "volume_tags": null,
            "vpc_security_group_ids": [
              "sg-03e4951a68d033c35"
            ]
          },
          "sensitive_attributes": [],
          "identity_schema_version": 0,
          "identity": {
            "account_id": "707264480025",
            "id": "i-0b8657b79ecce9dd3",
            "region": "ap-south-2"
          },
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTIwMDAwMDAwMDAwMCwicmVhZCI6OTAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMiJ9"
        }
      ]
    }
  ],
  "check_results": null
}

```

# 3. State file will hold the attributes of ec2 and eip 
We can use the state file to identiy public ip etc from the state file without accessing ec2 console