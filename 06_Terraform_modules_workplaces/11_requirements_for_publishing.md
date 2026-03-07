# Requirements

## github
The code must be in github

## x.y.z versioning
The release versioning must be x.y.z with optional v. 
v1.2.3 or 1.2.3

## Standard module structure
The module should follow the standard module structure
-> minimal structure
```
main.tf
variables.tf
output.tf
README.md
```
-> complete structure
```
main.tf
variables.tf
output.tf
README.md
modules 
  module1
    main.tf
    varibales.tf
    output.tf
    README.md
  module2
    main.tf
    varibales.tf
    output.tf
    README.md

examples
  example1
    README.md
  example2
    README.md
```

## Project descrition
The github description will be used as project description

## naming convention
The name of the github should be terraform-<provider>-<name>

