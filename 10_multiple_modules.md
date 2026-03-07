# multiple modules

<img width="1071" height="616" alt="Screenshot 2026-03-07 at 11 11 36 AM" src="https://github.com/user-attachments/assets/e3d8b9fa-89e1-4342-8927-fc6ca674617c" />


## we want the dev sg to be created in us-east-1
## we want the prod sg to be created in ap-south-2

If we specify in root module, all the SGs will be created in ap-south-2
- The provider block will be inherited by child module from root module
```
provider "aws" {
    region = "ap-south-2"
}

module "sg" {
    source = "./modules/sg"
}
```
```
resource "aws_security_group" "dev" {
    name = "dev"
}

resource "aws_security_group" "prod" {
    name = "prod"
}
```

<img width="851" height="615" alt="Screenshot 2026-03-07 at 11 21 45 AM" src="https://github.com/user-attachments/assets/fd2ec513-99c1-40cd-9b9b-3c0dc6c9f659" />


