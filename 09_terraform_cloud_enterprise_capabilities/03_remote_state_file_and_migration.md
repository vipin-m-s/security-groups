- HCP offers secure remote state file storage
- It maintains the history of the state files
- This can be used to maintain the state versions
- Can be used to analyze infrastructure changes over times,
- We can easily rollback to older version


# Migrate the terraform state file to HCP from local 

## 1.Apply resource
```
$ cat main.tf
resource "random_string" "example" {
  length = 16
}
```
```
$ terraform init
Initializing the backend...
Initializing provider plugins...
- Finding latest version of hashicorp/random...
- Installing hashicorp/random v3.8.1...
- Installed hashicorp/random v3.8.1 (signed by HashiCorp)
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
```

```
$ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # random_string.example will be created
  + resource "random_string" "example" {
      + id          = (known after apply)
      + length      = 16
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + numeric     = true
      + result      = (known after apply)
      + special     = true
      + upper       = true
    }

Plan: 1 to add, 0 to change, 0 to destroy.
random_string.example: Creating...
random_string.example: Creation complete after 0s [id=!hny:Q?5qCaYUr@#]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

```
$ cat terraform.tfstate
{
  "version": 4,
  "terraform_version": "1.14.6",
  "serial": 1,
  "lineage": "5617b8e7-3eac-7f5d-a754-e5877261cc05",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "random_string",
      "name": "example",
      "provider": "provider[\"registry.terraform.io/hashicorp/random\"]",
      "instances": [
        {
          "schema_version": 2,
          "attributes": {
            "id": "!hny:Q?5qCaYUr@#",
            "keepers": null,
            "length": 16,
            "lower": true,
            "min_lower": 0,
            "min_numeric": 0,
            "min_special": 0,
            "min_upper": 0,
            "number": true,
            "numeric": true,
            "override_special": null,
            "result": "!hny:Q?5qCaYUr@#",
            "special": true,
            "upper": true
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

# 2. Create workspace in HCP 

# 3. Add the cloud block 
```
$ cat main.tf
terraform {
  cloud {

    organization = "test-vipinms-1998"

    workspaces {
      name = "new-migrated"
    }
  }
}

resource "random_string" "example" {
  length = 16
}
```

# 4. Migrate
```
$ terraform init
Initializing HCP Terraform...
Do you wish to proceed?
  As part of migrating to HCP Terraform, Terraform can optionally copy
  your current workspace state to the configured HCP Terraform workspace.

  Answer "yes" to copy the latest state snapshot to the configured
  HCP Terraform workspace.

  Answer "no" to ignore the existing state and just activate the configured
  HCP Terraform workspace with its existing state, if any.

  Should Terraform migrate your existing state?

  Enter a value: yes

Initializing provider plugins...
- Reusing previous version of hashicorp/random from the dependency lock file
- Using previously-installed hashicorp/random v3.8.1

HCP Terraform has been successfully initialized!

You may now begin working with HCP Terraform. Try running "terraform plan" to
see any changes that are required for your infrastructure.

If you ever set or change modules or Terraform Settings, run "terraform init"
again to reinitialize your working directory.

```
state file will be migrated and state file here will be empty
```
$ cat terraform.tfstate
$
```

# To Skip the prompt, we can use terraform init -migrate-state flag
