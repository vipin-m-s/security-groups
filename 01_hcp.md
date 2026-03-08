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
