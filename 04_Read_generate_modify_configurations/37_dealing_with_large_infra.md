# Large infra

When we are working in production there may be 1000s of resources, We should directly perform 
terraform plam/apply commands since it might end up making multiple API calls to providers such as AWS, azure. 
These providers will have a API limitation. In production env this will be a problem if the API limitations are hit, then app will not be accessible

Solution to this are
1) Break down the resources into multiple smaller projects
Networking -> main.tf
Security -> main.tf
Instances -> main.tf
2) We can use only the target option to target specific resource
  With this only specific resource will be targetted
3) We can use -refresh=false
   With this we can prevent the resource refreshing when we do terraform plan. This should be done only when we are sure that desired state and actual state is same.
   
