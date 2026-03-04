# Map

We can spcify key value pairs using map data data type 

```
$ cat main.tf 

variable "my-map" {
  type = map
}                                                                                 

```

```
$ terraform plan
var.my-map
  Enter a value: ["hello"]


Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Invalid value for input variable
│ 
│   on main.tf line 2:
│    2: variable "my-map" {
│ 
│ Unsuitable value for var.my-map set using an interactive prompt: map of any
│ single type required.
╵
```

```
$ terraform plan
var.my-map
  Enter a value: {creator = "terraform"}


No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.
```


```
$ cat main.tf 

variable "my-map" {
  type = map
  default = {
    creator = "terraform"
  }
}                                                                                 

```
```
$ terraform plan

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.
```
