# Refresh 

- Terraform refresh command will check the latest state of your infrastructure and update the state file
- This is a very dangerous command to run, as it can make our state file to be empty
- Refresh is performed by terraform internally during plan and apply phase.

## 1. Provider region is us-east-1
## 2. Create ec2 instance
## 3. Update the region to us-west-2
## 4. Terraform refresh 
## 5. The entire state file becomes empty as the terrform is not able to find resources in us-west-2 region

- This command is deprecated in terraform
- refresh-only command is introduced with plan and apply command.
