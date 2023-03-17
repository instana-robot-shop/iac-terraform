# Infrastructure Design

# Reposity Structure
```
    global: global services, created only once
        ├── accounts, e.g. iam 
        │   ├── iam
        │       ├── diagrams
        │       │   ├── {resource}-design.drawio: drawio file used to edit the diagram
        │       │   ├── {resource}-design.drawio.png: png export of the diagram 
        │       ├── .auto.tfvars: gitignored file, typically used for specifying aws credentials automatically
        │       ├── main.tf: contains imported module to execute the creation of resources
        │       ├── output.tf: print specified values after creation of resources
        │       ├── provider.tf: specify cloud provider to use 
        │       ├── variables.tf: contains the variable to be used
        │       ├── version.tf: specify version of terraform and provider required
        ├── etc.
    environment: aws resource created on different environments
        ├── staging
        │   ├── {cloud-resource}, e.g. eks
        │       ├── diagrams
        │       │   ├── {resource}-design.drawio: drawio file used to edit the diagram
        │       │   ├── {resource}-design.drawio.png: png export of the diagram 
        │       ├── .auto.tfvars: gitignored file, typically used for specifying aws credentials automatically
        │       ├── main.tf: contains imported module to execute the creation of resources
        │       ├── output.tf: print specified values after creation of resources
        │       ├── provider.tf: specify cloud provider to use 
        │       ├── variables.tf: contains the variable to be used
        │       ├── version.tf: specify version of terraform and provider required
        ├── etc. 
    modules - reusable cloud resources called in /environment and /global (assuming we create our own customized module)
        ├── {cloud-resource}, e.g. eks 
        │    ├── {resource-cloud-resource}, e.g. aws_eks_cluster
        │    │   ├── main.tf
        │    │   ├── variables.tf
        │    ├── etc.
        ├── etc.
```

# Naming Convention
### Services/Workload
* https://peritossolutions.com/aws/aws-workload-naming-convention/

### Tags
* https://d0.awsstatic.com/aws-answers/AWS_Tagging_Strategies.pdf
* Additional Tags 
    * Terraform(boolean): if resource is created by terraform or not 

# Best Practices 
### All Environment
* Always look for ways to optimize costs

### Staging
* Goal: For testing before product is deployed in production, therefore focus is to have the same functionality features of prod but some features for high availability, fault tolerance, etc. which may incure more cost may not be present. 

### Production
* Goal: Fault Tolerance, High Availability, Disaster Recovery 
* Implement cross-region {feature} if possible 