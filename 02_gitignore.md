# gitignore

We should always add below files/folders from terraform to gitignore
- .terraform/
- *.tfstate
- *.tfstate.\* backup file
- .tfvars (not always, if it does not contain sensitive information, it can be committed)
- terraform.lock.info ( should not be commited, ideally would not be present in the folder )
- crash.log ( when terraform crashes, log is stored here )
- crash.*.log

Things to commit in terraform
- All the terraform files.
- The .gitignore file
- The terraform.hcl.lock file ( dependency lock )


# Remote backends 
We should never store tfstate file in git. Instead we can use s3, consul, azurerm, gcp to store state files

The suggested architecute is
devops team -> terraform code -> github
devops team -> terraform state files -> central location such as s3, consul, azure, gcp

By default TF uses local backend




