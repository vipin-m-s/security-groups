# object - data type 

Object data type is also a collection of key value pairs. 

## object type requireds a structure
```
var "object1" {
    type = object
}
```

## No changes. 
```
$ terraform plan                
╷
│ Error: Unsupported block type
│ 
│   on main.tf line 2:
│    2: var "object1" {
│ 
│ Blocks of type "var" are not expected here.
╵
```


## Object type can have different types of key values.
```
variable "object1" {
    type = object({ name = string , age = number })
}
```

```
$ terraform plan
var.object1
  Enter a value: {name="vipin",age="13"}


No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.
```

```

variable "object1" {
    type = object({ name = string , age = number })
}

$ terraform plan
var.object1
  Enter a value: {name="vipin",age="xxx"}


Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Invalid value for input variable
│ 
│   on main.tf line 2:
│    2: variable "object1" {
│ 
│ Unsuitable value for var.object1 set using an interactive prompt: a number is
│ required.
```

## When a key, value is passed that doesnt exist in structure, that newly added key value pair is trimmed
role is ignored here
```

variable "object1" {
    type = object({ name = string , age = number })
}

$ terraform plan
var.object1
  Enter a value: {name="vipin",age="13",role="devops"}


No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.
```
