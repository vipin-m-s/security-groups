# Git for team

- When we are using terraform in organization
- We should not store the tf files in local
- We should always store the tf files in git repository


Reasons for storing in git
- If the laptop crashes , then all the files and tf state file is lost
- If the files are present in local, team memembers cannot access hence collaboration fails
- If the files are present in local, we do not have the history of changes, we cannot rollback to previous change incase of issues.

We should not commit all the changes to git
- .terraform folder plugins are huge size, and the adding to git can timeout.
- When the team memebers anyways run terraform init, the plugins are downloaded
- .tfstate files also should not be stored in git.


## WHy tf state files should not be commited to github

- Committing the .tf state files to github can lead to security breach. THe .tfstate files can contain sensitive information like password, API Tokens etc.

### 1. Creating an AWS Database resource
```
 $ cat main.tf
resource "aws_db_instance" "default" {
	allocated_storage = 10
	db_name = "mydb"
	engine = "mysql"
	engine_version = "8.0"
	instance_class = "db.t3.micro"
	username = "foo"
	password = "foobarbaz#213"
	parameter_group_name = "default.mysql8.0"
	skip_final_snapshot = true
}
```
After performing terraform init and terraform apply. 
The tfstate file is created. The tfstate file will have the password stored in plain text format in the tf state file
```

```

- Some people assume that if we do not pass password in plain text format in config files, the password will not be stored in .tf state file.
- Incorrect , even if we pass password as file() the passowrd will be printed in .tfstate file
```
 $ cat main.tf
resource "aws_db_instance" "default" {
	allocated_storage = 10
	db_name = "mydb"
	engine = "mysql"
	engine_version = "8.0"
	instance_class = "db.t3.micro"
	username = "foo"
	password = file("pass.txt")
	parameter_group_name = "default.mysql8.0"
	skip_final_snapshot = true
}
```
The tf state file will stil print password
