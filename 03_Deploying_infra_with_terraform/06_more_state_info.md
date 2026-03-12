

- We provide just ami and instance type for creating an ec2 instance
- But other fields such as 8GB SSD storage and firewall are selected by AWS by default
- We did not have to specify these parameters, hence they are not considered as desired state
- If anyone logs into AWS conosle and modifed these settings.
- Then terraform will not track these and show changes. 
