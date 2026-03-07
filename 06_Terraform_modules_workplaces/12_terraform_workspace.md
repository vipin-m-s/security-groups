# Terraform workspace

- If we want to maintain 2 different envrionment using the same configuration file
- We can do it using workspace

By default there is default workspace created
```
$ terraform workspace list
* default
```

We can create new workpspace using terraform workspace new NAME
```
 $ terraform workspace new dev
Created and switched to workspace "dev"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
 $ terraform workspace new prod
Created and switched to workspace "prod"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
```

We can delete workspace using delte
```
 $ terraform workspace delete deprod
Deleted workspace "deprod"!
 $
```

We cannot delete default workspace
```
 $ terraform workspace delete default
Cannot delete the default workspace
```

When we create workspaces, There would be folders created for each workpsace
```
 $ terraform workspace list
  default
  dev
* prod
```

```
 $ tree
.
└── terraform.tfstate.d
    ├── dev
    └── prod
```

- When we create resources in each workspace.
- The state of the resources would be stored within these workspace folders.
- This is done to create separate environment


