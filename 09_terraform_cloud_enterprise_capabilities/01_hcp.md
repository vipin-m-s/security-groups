# HCP 

HCP has below structure
1) organization -> billing is done per organization basis
2) Workspace -> local directory in our laptop == workspace.
3) Projects -> group of workspaces is called project

## difference between Workspace and local directory
Terraform configuration:- on disk, in HCP it is stored in github
state file:- In terraform cli its stored in local directory, in HCP it is stored in workspace
varibales:- stored in .tfvars file , in HCP it is stored in workspace
Passwords:- stoed as env varibales, in HCP stored in workspace as sensitive variable

## version control workflow
- WE can create version control workflow for Terraform
- We need to add github account and link it when creating workspace
- Any changes to files in that repository, A plan and apply run will be triggered
- If plan is successful, APply will not be triggered automatically.
- A person will review and he can approve
- The plan if it fails. It will give Errored state
- The required AWS secret key and AWS access keys needs to be added as environment variables in workspace

## CLI driven workflow
- We can also use CLI driven workflow
- WE can connect HCP with CLI
- When we perform terraform plan and apply.
- The operation will run remmotely in HCP and not in local
- The credentials for AWS needs to be configured in HCP workspace

### 1. setup cloud integration 
```
terraform {
  cloud {

    organization = "test-vipinms-1998"

    workspaces {
      name = "cli-driven"
    }
  }
}
```

### 2. perform terraform login and supply the token
```
terraform login
Terraform will request an API token for app.terraform.io using your browser.

If login is successful, Terraform will store the token in plain text in
the following file for use by subsequent commands:
    /Users/vipin/.terraform.d/credentials.tfrc.json

Do you want to proceed?
  Only 'yes' will be accepted to confirm.

  Enter a value: yes


---------------------------------------------------------------------------------

Terraform must now open a web browser to the tokens page for app.terraform.io.

If a browser does not open this automatically, open the following URL to proceed:
    https://app.terraform.io/app/settings/tokens?source=terraform-login


---------------------------------------------------------------------------------

Generate a token using your browser, and copy-paste it into this prompt.

Terraform will store the token in plain text in the following file
for use by subsequent commands:
    /Users/vipin/.terraform.d/credentials.tfrc.json

Token for app.terraform.io:
  Enter a value:

```

### 3. perform terraform init
```
$ terraform init

Initializing HCP Terraform...
Initializing provider plugins...

HCP Terraform has been successfully initialized!

You may now begin working with HCP Terraform. Try running "terraform plan" to
see any changes that are required for your infrastructure.

If you ever set or change modules or Terraform Settings, run "terraform init"
again to reinitialize your working directory.
```

### 4. perform terraform plan
```
Running plan in HCP Terraform. Output will stream here. Pressing Ctrl-C
will stop streaming the logs, but will not stop the plan running remotely.

Preparing the remote plan...

To view this run in a browser, visit:
https://app.terraform.io/app/test-vipinms-1998/cli-driven/runs/run-oGfDgFvNg2yTqUPu

Waiting for the plan to start...

Terraform v1.14.6
on linux_amd64
Initializing plugins and modules...

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
```
