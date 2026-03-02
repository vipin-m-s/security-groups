# Data sources

We can fetch and read some information from digitalocean, local and aws using data sources and pass it to the resources for moidying / execute logic further

# Example 1 - reading file contents 

```
$ cat main.tf 
data "local_file" "file" {
  filename = "${path.module}/test.txt"
}                                                                                      
```
```
$ terraform apply -auto-approve  
data.local_file.file: Reading...
data.local_file.file: Read complete after 0s [id=a7b8fc28b9a538ef5335ff92e0580670a9fc3461]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no
differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```
The resource would be availanble in terraform.tfstate file
```
$ cat tfstate
{
  "version": 4,
  "terraform_version": "1.14.6",
  "serial": 74,
  "lineage": "a55b4513-8c58-c3c5-6069-98e054c6a35c",
  "outputs": {},
  "resources": [
    {
      "mode": "data",
      "type": "local_file",
      "name": "file",
      "provider": "provider[\"registry.terraform.io/hashicorp/local\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "content": "File for random testing~\n1\n2\n3",
            "content_base64": "RmlsZSBmb3IgcmFuZG9tIHRlc3Rpbmd+CjEKMgoz",
            "content_base64sha256": "O8IhnCibIK+UmguNHyjoQ008st+6uy8VFfzKfISUMO4=",
            "content_base64sha512": "IWVFrLgOGgQ0yc7bOvnoPRp/7dKJaNaQkfYNGTEfl4AnDZP4f75gQCOlPnyGdllexfHfPr8U7CnN9vavFE61PQ==",
            "content_md5": "aa6e04425db66ad221f3db4b5443132b",
            "content_sha1": "a7b8fc28b9a538ef5335ff92e0580670a9fc3461",
            "content_sha256": "3bc2219c289b20af949a0b8d1f28e8434d3cb2dfbabb2f1515fcca7c849430ee",
            "content_sha512": "216545acb80e1a0434c9cedb3af9e83d1a7fedd28968d69091f60d19311f9780270d93f87fbe604023a53e7c8676595ec5f1df3ebf14ec29cdf6f6af144eb53d",
            "filename": "./test.txt",
            "id": "a7b8fc28b9a538ef5335ff92e0580670a9fc3461"
          },
          "sensitive_attributes": [],
          "identity_schema_version": 0
        }
      ]
    }
  ],
  "check_results": null
}
```

# Example 2 - We can also deploy ec2 instance and read about the instance details using data sources block

```
$ cat main.tf 
resource "aws_instance" "webapp" {
  ami = "ami-090b9c8aa1c84aefc"
  instance_type = "t3.micro"
  count = 2

  tags = {
    Name = "webapp-${count.index}"
  }
}

data "aws_instances" "instance_details" {}

output "instance_details" {
  value = data.aws_instances.instance_details
}
```
```
$ terraform apply -auto-approve
data.aws_instances.instance_details: Reading...
aws_instance.webapp[1]: Refreshing state... [id=i-0e3af3dc76b45d53b]
aws_instance.webapp[0]: Refreshing state... [id=i-022a0032625d7bfb0]
data.aws_instances.instance_details: Read complete after 0s [id=ap-south-2]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no
differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

instance_details = {
  "filter" = toset(null) /* of object */
  "id" = "ap-south-2"
  "ids" = tolist([
    "i-0e3af3dc76b45d53b",
    "i-022a0032625d7bfb0",
  ])
  "instance_state_names" = toset(null) /* of string */
  "instance_tags" = tomap(null) /* of string */
  "ipv6_addresses" = tolist([])
  "private_ips" = tolist([
    "172.31.3.227",
    "172.31.14.160",
  ])
  "public_ips" = tolist([
    "40.192.100.97",
    "98.130.44.56",
  ])
  "region" = "ap-south-2"
  "timeouts" = null /* object */
}
$ 
```
