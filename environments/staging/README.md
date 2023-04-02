# Logical Explanation
https://antonputra.com/amazon/create-eks-cluster-using-terraform-modules/#create-aws-vpc-using-terraform

# Diagram

# VPC
## VPC Network Best Practices 
### from TrendMicro 
* [] **AWS VPC Peering Connections Route Tables Access**: Ensure that the Amazon VPC peering connection configuration is compliant with the desired routing policy.
* [] **AWS VPN Tunnel State**: Ensure the state of your AWS Virtual Private Network (VPN) tunnels is UP
* [] **Ineffective DENY Rules for Network ACLs**: Ensure that Network ACL DENY rules are effective within your VPC network configuration.
* [] **Managed NAT Gateway In Use**: Ensure AWS VPC Managed NAT (Network Address Translation) Gateway service is enabled for high availability (HA).
* [] **Specific Gateway Attached to Specific VPC**: Ensure that a specific Internet/NAT gateway is attached to a specific VPC.
* [] **Unrestricted Inbound Traffic on Remote Server Administration Ports**: Ensure that no Network ACL (NACL) allows unrestricted inbound traffic on TCP ports 22 and 3389.
* [] **Unrestricted Network ACL Inbound Traffic**: Ensure that no Network ACL (NACL) allows inbound/ingress traffic from all ports.
* [] **Unrestricted Network ACL Outbound Traffic**: Ensure that no Network ACL (NACL) allows outbound/egress traffic to all ports.
* [] **Unused VPC Internet Gateways**: Ensure unused VPC Internet Gateways and Egress-Only Internet Gateways are removed to follow best practices.
* [] **Unused Virtual Private Gateways**: Ensure unused Virtual Private Gateways (VGWs) are removed to follow best practices.
* [] **VPC Endpoint Cross Account Access**: Ensure Amazon VPC endpoints do not allow unknown cross account access.
* [] **VPC Endpoint Exposed**: Ensure Amazon VPC endpoints are not exposed to everyone.
* [] **VPC Endpoints In Use**: Ensure VPC endpoints are being used to connect your VPC to another AWS service.
* [] **VPC Flow Logs Enabled**: Ensure Virtual Private Cloud (VPC) Flow Logs feature is enabled in all applicable AWS regions.
* [] **VPC Naming Conventions**: Ensure AWS VPCs are using proper naming conventions to follow AWS tagging best practices.
* [] **VPC Peering Connections To Accounts Outside AWS Organization**: Ensure VPC peering communication is only between AWS accounts, members of the same AWS Organization.
* [] **VPN Tunnel Redundancy**: Ensure AWS VPNs have always two tunnels active in order to enable redundancy.

### from AWS
#### Architecting
* Consider atleast two to four Availability Zones for high availability and disaster recovery. (AWS recommends maximizing your use of Availability Zones to isolate a data center outage.) Availability Zones are geographically distributed within a region and spaced for best insulation and stability in the event of a natural disaster.

* Separate subnets for unique routing requirements. AWS recommends using public subnets for external-facing resources and private subnets for internal resources. For each Availability Zone, this Quick Start provisions one public subnet and one private subnet by default. (If you need public subnets only, you can disable the creation of the private subnets.) For subnet sizing strategies, see the next section.

* Additional layer of security. AWS recommends using network ACLs as firewalls to control inbound and outbound traffic at the subnet level. This Quick Start provides an option to create a network ACL protected subnet in each Availability Zone. These network ACLs provide individual controls that you can customize as a second layer of defense.

* We recommend that you use network ACLs sparingly for the following reasons: they can be complex to manage, they are stateless, every IP address must be explicitly opened in each (inbound/outbound) direction, and they affect a complete subnet. We recommend that you use security groups more often than network ACLs, and create and apply these based on a schema that works for your organization. Some examples are server roles and application roles. For more information about security groups and network ACLs, see the Security section later in this guide.

* Independent routing tables configured for every private subnet to control the flow of traffic within and outside the Amazon VPC. The public subnets share a single routing table, because they all use the same Internet gateway as the sole route to communicate with the Internet.

* Highly available NAT gateways, where supported, instead of NAT instances. NAT gateways offer major advantages in terms of deployment, availability, and maintenance. For more information see the comparison provided in the Amazon VPC documentation.

* Spare capacity for additional subnets, to support your environment as it grows or changes over time.

#### Security 
* When you add subnets to your VPC to host your application, create them in multiple Availability Zones. An Availability Zone is one or more discrete data centers with redundant power, networking, and connectivity in an AWS Region. Using multiple Availability Zones makes your production applications highly available, fault tolerant, and scalable. For more information, see Building a Modular and Scalable Virtual Network Architecture with Amazon VPC.

* Use network ACLs to control access to your subnets and use security groups to control traffic to EC2 instances in your subnets. For more information, see Control traffic to subnets using Network ACLs and Control traffic to resources using security groups.

* Manage access to AWS VPC resources and APIs using AWS Identity and Access Management (IAM) identity federation, users, and roles. For more information, see Identity and access management for Amazon VPC.

* Use Amazon CloudWatch with VPC flow logs to monitor the IP traffic going to and from network interfaces in your VPC. For more information, see Publish flow logs to CloudWatch Logs.

### from AWS Startups
* https://medium.com/aws-activate-startup-blog/practical-vpc-design-8412e1a18dcc

### from random websites i found online
* It's a good practice to add a bastion host to increase security 

# IAM
## Accounts Management Design
![Accounts Management Design, Reference: https://docs.aws.amazon.com/whitepapers/latest/organizing-your-aws-environment/basic-organization.html](./diagrams/accounts-design.drawio.png)
The design incorporates a security tooling environment for common security services, a second workload, and support for sandbox and development environments. Additions include:

A Sandbox OU contains accounts in which your builders are generally free to explore and experiment with AWS services and other tools and services subject to your acceptable use policies.

An additional workload in the form of workload-b-prod, workload-b-test, and workload-b-dev accounts.

A Dev OU under the Workloads OU to contain development environment accounts associated with the workloads.

## IAM Best Practices 
### from TrendMicro
* [] **AWS Account Root User Activity**: Monitor AWS Account Root User Activity
* [] **AWS IAM Groups with Admin Privileges**: Ensure there are no IAM groups with full administrator permissions within your AWS account.
* [] **AWS IAM Password Policy**: Ensure AWS account has an IAM strong password policy in use
* [] **AWS IAM Server Certificate Size**: Ensure that all your SSL/TLS certificates are using either 2048 or 4096 bit RSA keys instead of 1024-bit keys.
* [] **AWS IAM Users with Admin Privileges**: Ensure there are no IAM users with full administrator permissions within your AWS account.
* [] **AWS Multi-Account Centralized Management**: Set up, organize and manage your AWS accounts for optimal security and manageability.
* [] **Access Keys During Initial IAM User Setup**: Ensure no access keys are created during IAM user initial setup with AWS Management Console.
* [] **Access Keys Rotated 30 Days**: Ensure AWS IAM access keys are rotated on a periodic basis as a security best practice (30 Days).
* [] **Access Keys Rotated 45 Days**: Ensure AWS IAM access keys are rotated on a periodic basis as a security best practice (45 Days).
* [] **Access Keys Rotated 90 Days**: Ensure AWS IAM access keys are rotated on a periodic basis as a security best practice (90 Days).
* [] **Account Alternate Contacts**: Ensure alternate contacts are set to improve the security of your AWS account.
* [] **Account Security Challenge Questions**: Ensure security challenge questions are enabled and configured to improve the security of your AWS account.
* [] **Approved ECS Execute Command Access**: Ensure that all access to the ECS Execute Command action is approved
* [] **Attach Policy to IAM Roles Associated with App-Tier EC2 Instances**: Ensure IAM policy for EC2 IAM roles for app tier is configured.
* [] **Attach Policy to IAM Roles Associated with Web-Tier EC2 Instances**: Ensure IAM policy for EC2 IAM roles for web tier is configured.
* [] **Canary Access Token**: Detechs when a canary token access key has been used.
* [] **Check for IAM User Group Membership**: Ensure that all Amazon IAM users have group memberships.
* [] **Check for Overly Permissive IAM Group Policies**: Ensure that Amazon IAM policies attached to IAM groups are not too permissive.
* [] **Check for Unapproved IAM Users Existence**: Ensure there are no unapproved Amazon IAM users available within your AWS cloud account.
* [] **Check for Untrusted Cross-Account IAM Roles**: Ensure that AWS IAM roles cannot be used by untrusted accounts via cross-account access feature.
* [] **Credentials Last Used**: Ensure that unused AWS IAM credentials are decommissioned to follow security best practices.
* [] **Cross-Account Access Lacks External ID and MFA**: Ensure cross-account IAM roles use either MFA or external IDs to secure the access to AWS resources.
* [] **Enable MFA for IAM Users with Console Password**: Ensure that Multi-Factor Authentication (MFA) is enabled for all Amazon IAM users with console access.
* [] **Expired SSL/TLS Certificate**: Ensure expired SSL/TLS certificates are removed from AWS IAM.
* [] **Hardware MFA for AWS Root Account**: Ensure hardware MFA is enabled for your Amazon Web Services root account.
* [] **IAM Access Analyzer in Use**: Ensure that IAM Access Analyzer feature is enabled to maintain access security to your AWS resources.
* [] **IAM Configuration Changes**: AWS IAM configuration changes have been detected within your Amazon Web Services account.
* [] **IAM CreateLoginProfile detected**: AWS IAM 'CreateLoginProfile' call has been detected within your Amazon Web Services account.
* [] **IAM Group With Inline Policies**: Ensure AWS IAM groups do not have inline policies attached.
* [] **IAM Master and IAM Manager Roles**: Ensure that IAM Master and IAM Manager roles are active in your AWS cloud account.
* [] **IAM Policies With Full Administrative Privileges**: Ensure IAM policies that allow full "*:*" administrative privileges are not created.
* [] **IAM Policies with Effect Allow and NotAction**: Ensure AWS IAM policies do not use "Effect" : "Allow" in combination with "NotAction" element to follow security best practices.
* [] **IAM Role Policy Too Permissive**: Ensure AWS IAM policies attached to IAM roles are not too permissive.
* [] **IAM User Password Expiry 30 Days**: Ensure AWS Identity and Access Management (IAM) user passwords are reset before expiration (30 Days).
* [] **IAM User Password Expiry 45 Days**: Ensure AWS Identity and Access Management (IAM) user passwords are reset before expiration (45 Days).
* [] **IAM User Password Expiry 7 Days**: Ensure AWS Identity and Access Management (IAM) user passwords are reset before expiration (7 Days).
* [] **IAM User Policies**: Ensure AWS IAM policies are attached to groups instead of users as an IAM best practice.
* [] **IAM User Present**: Ensure there is at least one IAM user currently used to access your AWS account.
* [] **IAM User with Password and Access Keys**: Ensure that IAM users have either API access or console access in order to follow IAM security best practices.
* [] **IAM Users Unauthorized to Edit Access Policies**: Ensure AWS IAM users that are not authorized to edit IAM access policies are decommissioned..
* [] **Inactive IAM Console User**: Ensure no AWS IAM users have been inactive for a long (specified) period of time.
* [] **MFA Device Deactivated**: A Multi-Factor Authentication (MFA) device deactivation for an IAM user has been detected.
* [] **Pre-Heartbleed Server Certificates**: Ensure that your server certificates are not vulnerable to Heartbleed security bug.
* [] **Receive Permissions via IAM Groups Only**: Ensure that IAM users receive permissions only through IAM groups.
* [] **Root Account Access Keys Present**: Ensure that your AWS root account is not using access keys as a security best practice.
* [] **Root Account Active Signing Certificates**: Ensure that your AWS root account user is not using X.509 certificates to validate API requests.
* [] **Root Account Credentials Usage**: Ensure that root account credentials have not been used recently to access your AWS account.
* [] **Root MFA Enabled**: Ensure that Multi-Factor Authentication (MFA) is enabled for your AWS root account.
* [] **SSH Public Keys Rotated 30 Days**: Ensure AWS IAM SSH public keys are rotated on a periodic basis as a security best practice.
* [] **SSH Public Keys Rotateed 45 Days**: Ensure IAM SSH public keys are rotated on a periodic basis to adhere to AWS security best practices.
* [] **SSH Public Keys Rotated 90 Days**: Ensure IAM SSH public keys are rotated on a periodic basis to adhere to AWS security best practices.
* [] **SSL/TLS Certificate Expiry 30 Days**: Ensure SSL/TLS certificates are renewed before their expiration.
* [] **SSL/TLS Certificate Expiry 45 Days**: Ensure SSL/TLS certificates are renewed before their expiration.
* [] **SSL/TLS Certificate Expiry 7 Days**: Ensure SSL/TLS certificates are renewed before their expiration.
* [] **Sign-In Events**: AWS sign-in events for IAM and federated users have been detected.
* [] **Support Role**: Ensure there is an active Amazon IAM Support Role available within your AWS account.
* [] **Unapproved IAM Policy in Use**: Ensure there are no unapproved AWS Identity and Access Management (IAM) policies in use.
* [] **Unnecessary Access Keys**: Ensure there is a maximum of one active access key pair available for any single IAM user.
* [] **Unnecessary SSH Public Keys**: Ensure there is a maximum of one active SSH public keys assigned to any single IAM user.
* [] **Unused IAM Group**: Ensure AWS IAM groups have at least one user attached as a security best practice.
* [] **Unused IAM User**: Ensure unused IAM users are removed from AWS account to follow security best practice.
* [] **Valid IAM Identity Providers**: Ensure valid IAM Identity Providers are used within your AWS account for secure user authentication and authorization.



# EKS
## EKS Best Practices 
### from TrendMicro 
* [] **

# Logical process used in creating EKS
* Used an open-source eks module instead of creating your own using terraform resources
* Used a default VPC instead of defining your own

# ECR
## ECR Best Practices 
### from TrendMicro
* [/] Ensure that AWS Elastic Container Registry (ECR) repositories are not exposed to everyone. Do not give access to every IAM user.
* [] Ensure that Cross-Region Replication feature is enabled for your Amazon ECR container images.
* [/] Ensure that each Amazon ECR container image is automatically scanned for vulnerabilities when pushed to a repository.
* [/] Ensure that Amazon ECR image repositories are using lifecycle policies for cost optimization.
* [] Ensure that Amazon ECR repositories do not allow unknown cross account access.

### from Harshad Ranganathan (Lead Software Engineer)
* https://rharshad.com/ecr-best-practices/