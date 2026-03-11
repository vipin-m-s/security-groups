# AWS key config

First we learnt the easy way of providing AWS access to terraform using key and secret key
```
provider "aws" {
  region = ""
  access_key = ""
  secret_key = ""
}
```

This approach is a security risk, We should not do it
If someone pushes this to public github repository
THis will compromise the access to AWS
We can export the AWS keys as env variables
```
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY_ID=""
```

We can use shared config files. 
```
provider "aws" {
  shared_config_files=["/Users/test/.aws/config"]
  shared_credential_files=["/Users/test/.aws/credentials"]
  region = "us-east-1"
}
```

If the shared config files are not mentioned, then
The terraform will look for these credntials in $HOME/.aws/config and $HOME/.aws/credentials folders.
This will leave provider config clean
```
provider "aws" {
  region = "us-east-1"
}
```


