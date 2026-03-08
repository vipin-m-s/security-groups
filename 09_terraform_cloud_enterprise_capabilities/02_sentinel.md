# Sentinel

- Sentinel is a policy as code framework
- After plan is success, We can add checks
- If check passes, Terraform apply can be done
- If check fails, Terraform apply will be blocked.

# 1. Create Policy set and connect with workspace

# 2. Create Policy 

# 3. Create main.tf with ec2 instance without tags
```
resource "aws_instance" "app" {
  ami = "ami-022062aacfecac5bd"
  instance_type = "t3.micro"
}
```

# 4. run should fail 
<img width="1558" height="767" alt="Screenshot 2026-03-08 at 1 46 59 PM" src="https://github.com/user-attachments/assets/d72f5e2b-f885-4e71-bf54-5cd07483458e" />

# 5. Modify the main.tf
```
resource "aws_instance" "app" {
  ami = "ami-022062aacfecac5bd"
  instance_type = "t3.micro"
  tags = {
    Name = ec2
  }
}
```

# 6. Should succeed

