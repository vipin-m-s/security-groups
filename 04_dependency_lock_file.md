# terraform.lock.hcl

Suppose
- we have aws provider v1.4.1
- We have performed all our testing with v1.4.1
- And when the app is deployed in production, new provider plugin becomes available and
- Latest is downloaded. v1.6.0
- And our tested code does not work with v1.6.0
- This will create problem
- hence terraform.lock.hcl file is important file.
- The same version of providers will be downloaded.
