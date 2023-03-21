# EKS Cluster Design
![EKS Cluster Design](./diagrams/eks-cluster-design.drawio.png)

# EKS Best Practices 
### from TrendMicro 
* [] **EKS Cluster Endpoint Public Access**: Ensure that AWS EKS cluster endpoint access isn't public and prone to security risks.
* [] **EKS Security Groups**: Ensure that AWS EKS security groups are configured to allow incoming traffic only on TCP port 443.
* [] **Enable Envelope Encryption for EKS Kubernetes Secrets**: Ensure that envelope encryption of Kubernetes secrets using Amazon KMS/HC Vault is enabled.
* [] **Kubernetes Cluster Logging**: Ensure that EKS control plane logging is enabled for your Amazon EKS clusters.
* [] **Kubernetes Cluster Version**: Ensure that the latest version of Kubernetes is installed on your Amazon EKS clusters.
* [] **Monitor Amazon EKS Configuration Changes**: Amazon EKS configuration changes have been detected within your Amazon Web Services account.

### from AVM Consulting
* https://medium.com/avmconsulting-blog/aws-best-practice-for-amazon-elastic-kubernetes-service-eks-7ae468869724

### from AWS
#### Security
* https://aws.github.io/aws-eks-best-practices/security/docs/

#### Reliability
* https://aws.github.io/aws-eks-best-practices/reliability/docs/

#### Cluster Autoscaling
* https://aws.github.io/aws-eks-best-practices/cluster-autoscaling/

#### Running Windows Container
* https://aws.github.io/aws-eks-best-practices/windows/docs/ami/

#### Networking
* https://aws.github.io/aws-eks-best-practices/networking/index/