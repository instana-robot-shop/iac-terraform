# Infrastructure Design

# Reposity Structure
Alternative Repository Structure: https://www.youtube.com/watch?v=kZX3KLOZvhY
```
    environment
        ├── staging
        │   ├── .diagrams: manually-created/auto-generated diagrams
        │   ├── .pluralith: auto generate diagram for resources created by terraform
        │   ├── cluster: apps to be installed in the eks cluster; in simple words, to bootstrap the cluster
        │   │   ├── application: microservice application stored as helm chart
        │   │   │   ├── microservice-app.tf
        │   │   ├── cicd
        │   │   │   ├── jenkins.tf
        │   │   │   ├── mattermost.tf: for cicd chatops
        │   │   │   ├── sonarqube.tf
        │   │   │   ├── vault.tf
        │   │   ├── gitops
        │   │   │   ├── argocd.tf
        │   │   ├── addons
        │   │   │   ├── karpenter.tf: for eks cluster autoscaling
        │   │   │   ├── load-balancer-controller: for creating ingress and service of type load balancer in eks
        │   │   ├── monitoring
        │   │   │   ├── grafana.tf 
        │   │   │   ├── prometheus.tf: for monitoring eks cluster 
        │   ├── infrastructure 
        │   │   ├── ecr.tf: for storing docker images
        │   │   ├── eks.tf: k8s cluster
        │   │   ├── iam.tf: for structuring aws infra users 
        │   │   ├── vpc.tf: networking
        ├── prod
        ├── dev
```
# How to setup everything
* Install all prerequisites
    * AWS (CLI)
    * Kubectl
    * Helm
    * Docker
* Terraform apply to provision the entire infrastructure
* Assume role from a user for eks
* aws eksctl -- to access eks cluster

* build jar file and image then push to dockerhub and also make it deployable to k8s cluster
    * create a settings.xml (to be able to add your dockerhub credentials) from Mavens home directory: ${maven.home}/conf/settings.xml
    * perform for each microservice app
        * add specified plugins in pom.xml so you can build a docker image out of the app
        * add a Dockerfile to be able to build an image
        * add eureka configuration inside application.yml (idk the purpose of this shit but its somehow connected in k8s)
            * inside configuration there are variables to be inserted (e.g. ${HOSTNAME}) in which the value are inserted from configmaps in k8s
        * mvn clean package dockerfile:push
* deploy application to k8s cluster 
    * create manifests for each k8s resources based on the architecture
    # 35:33 https://www.youtube.com/watch?v=VAmntTPebKE


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