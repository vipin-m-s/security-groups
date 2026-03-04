# Set - data type

## List

In case of list there can be duplicate entries and list can be accessed via indexing

```
variable "mylist" {
    type = list
    default = ["Alice", "Bob", "Charlie"]
}

output "out" {
    value = var.mylist
}
```

```
$ terraform apply -auto-approve

Changes to Outputs:
  + out = [
      + "Alice",
      + "Bob",
      + "Charlie",
    ]

You can apply this plan to save these new output values to the Terraform state,
without changing any real infrastructure.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

out = tolist([
  "Alice",
  "Bob",
  "Charlie",
])
```

```
variable "mylist" {
    type = list
    default = ["Alice", "Bob", "Charlie", "Alice"]
}

output "out" {
    value = var.mylist
}

```
Alice can occur 2 times
```
$ terraform apply -auto-approve

Changes to Outputs:
  ~ out = [
        # (2 unchanged elements hidden)
        "Charlie",
      + "Alice",
    ]

You can apply this plan to save these new output values to the Terraform state,
without changing any real infrastructure.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

out = tolist([
  "Alice",
  "Bob",
  "Charlie",
  "Alice",
])
```

## Set 
```
variable "myset" {
    type = set(string)
    default = ["Alice", "Bob", "Charlie", "Alice"]
}

output "out" {
    value = var.myset
}
╵

```
```
$ terraform apply -auto-approve

Changes to Outputs:
  ~ out = [
        # (2 unchanged elements hidden)
        "Charlie",
      - "Alice",
    ]

You can apply this plan to save these new output values to the Terraform state,
without changing any real infrastructure.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

out = toset([
  "Alice",
  "Bob",
  "Charlie",
])


```



If we change order in a set, there is no changes in infra
```
variable "myset" {
    type = set(string)
    default = ["Charlie", "Alice", "Bob"]
}

output "out" {
    value = var.myset
}
```
```
$ terraform apply -auto-approve

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

out = toset([
  "Alice",
  "Bob",
  "Charlie",
])
```


But when we change the order of element in a list, 
```
variable "mylist" {
    type = list
    default = ["Alice", "Bob", "Charlie"]
}

output "out" {
    value = var.mylist
}
```
```
$ terraform apply -auto-approve

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and
found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

out = tolist([
  "Alice",
  "Bob",
  "Charlie",
])

```
Now move chalie to the front
```

variable "mylist" {
    type = list
    default = ["Charlie", "Alice", "Bob"]
}

output "out" {
    value = var.mylist
}

```
We can observe changes
```
$ terraform apply -auto-approve

Changes to Outputs:
  ~ out = [
      + "Charlie",
        "Alice",
        "Bob",
      - "Charlie",
    ]

You can apply this plan to save these new output values to the Terraform state,
without changing any real infrastructure.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

out = tolist([
  "Charlie",
  "Alice",
  "Bob",
])
```

### Any infra that is dependent on list will change when the list itself changes w.r.t ordering of elements. 
### If the infra is dependent on set, there will not be any changes
