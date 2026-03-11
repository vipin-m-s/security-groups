# desired state / current state

desired state :- The resource configuration we write in .tf file is the desired state 
current state :- the actual infrastructure resources created in AWS is the current state 

## Consider a scenario where
1) AWS instance was created using terraform using t3.micro type.
2) Now the current state == desired state
3) Then a team member logs into AWS console and modifies the instance type to t3.small
4) Now the current state != desired state
5) Terraform loves the desired state and hence tries to bring the infra back to desired state.
6) The ec2 instance is modifed by `terraform apply` to change the instance type back to t3.micro


- If resource exists in desired state, but does not exist in currnet state -> TF will create that resource
- If resource does not exist in desired state, but exists in current state -> TF will delete that resource
- If both exists, But resource was modified manually -> TF will update the resource back to desired state
- If there is no operation -> desired state == current state -> TF will not perform any changes
