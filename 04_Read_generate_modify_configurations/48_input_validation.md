# Input validation 

Assume we are requiring passowrd for database password. We do not want it to be less than 12 characters.
We can add input validation for the variable and throw an error when validation fails
## 1. Create a variable with validation
```
$ cat main.tf 
variable "db_password" {
    type = string 

    validation {
        condition = length(var.db_password) >= 12
        error_message = "Password is < 12, Should be >= 12"
    }
}
```

# 2. Execute plan  with < 12 chars
```                                                                          
$ terraform plan
var.db_password
  Enter a value: admin


Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Invalid value for variable
│ 
│   on main.tf line 1:
│    1: variable "db_password" {
│     ├────────────────
│     │ var.db_password is "admin"
│ 
│ Password is < 12, Should be >= 12
│ 
│ This was checked by the validation rule at main.tf:4,5-15.
╵
$
```

## 3. Execute plan with password >= 12
```
$ terraform plan
var.db_password
  Enter a value: 123456789101112


No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration
and found no differences, so no changes are needed.
```
