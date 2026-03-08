# sensitive

- Suppose we want to use passwords, api tokens etc
- We do not want sensitive content to be displayed on the CLI output or logs

## Creating a password file

```
resource "local_file" "pass" {
  filename = "./pass.txt"
  content = "PASSWORD"
}
```

```
  # local_file.pass will be created
  + resource "local_file" "pass" {
      + content              = "PASSWORD"
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "./pass.txt"
      + id                   = (known after apply)
    }
```
## We need to create a variable with sensitive = true
```
$ cat main.tf
variable "password" {
  default = "PASSWORD"
  sensitive = true
}

resource "local_file" "pass" {
  filename = "./pass.txt"
  content = var.password
}
```

the data would be hidden
```
  + resource "local_file" "pass" {
      + content              = (sensitive value)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "./pass.txt"
      + id                   = (known after apply)
    }
```

## Sensitive data in output variable
- By default we cannot add sensitive data to output variables. -
- We can override this behaviour with by adding sensitive = true
- sensitive output variable can be used by other projects if they want to access the password
```
$ cat main.tf
variable "password" {
  default = "PASSWORD"
  sensitive = true
}

resource "local_file" "pass" {
  filename = "./pass.txt"
  content = var.password
}

output "pass" {
  value = local_file.pass.content
}
```
```
╷
│ Error: Output refers to sensitive values
│
│   on main.tf line 11:
│   11: output "pass" {
│
│ To reduce the risk of accidentally exporting sensitive data that was intended to be only internal, Terraform requires that any root module output containing sensitive data be explicitly marked
│ as sensitive, to confirm your intent.
│
│ If you do intend to export this data, annotate the output value as sensitive by adding the following argument:
│     sensitive = true
╵
```

```
$ cat main.tf
variable "password" {
  default = "PASSWORD"
  sensitive = true
}

resource "local_file" "pass" {
  filename = "./pass.txt"
  content = var.password
}

output "pass" {
  value = local_file.pass.content
  sensitive = true
}
```

```
Terraform will perform the following actions:

  # local_file.pass will be created
  + resource "local_file" "pass" {
      + content              = (sensitive value)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "./pass.txt"
      + id                   = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + pass = (sensitive value)
```

By default sonme resources will implicitly make its fields as sensitive
For example Amazon RDS isntacen password field, implicitly is sensistive
