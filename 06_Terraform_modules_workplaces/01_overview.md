# Modules

- Suppose there is 10 teams in an org
- Evryone wants to create ec2 instances
- They will start maintaining their own terraform config
- But there are several issues


## 1. Violated DRY 
- There is repitiion of code
- violates the DRY principle


## 2. Changes to aws provider option, means every team has to update their configuration files
- change from ami to image_id would require 10 teams to update
- There is not centralized management

## 3. There is no standardization
- Each team will follow their own method
- There is no standardization in terms of Security

## 4. Difficult to maintain

## 5. Difficult for developers to use


Hence modules were introduced. 
- Modules are the templates from which teams can created resources
- Any changes to provider means update only to the template
- abstracts the complexity for developers
- We can reuse exisiting templates from other teams or from other organization.
- It is a centralized configuration management solution
