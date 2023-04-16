/**
  * required for karpenter
*/
data "aws_partition" "current" {}

locals {
  partition = data.aws_partition.current.partition
}

/**
  * create eks cluster
*/
module "eks" {
  count = var.environment != "dev" ? 1 : 0

  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.23"

  # cluster endpoint private: to access the cluster from a bastion host or vpn
  # cluster endpoint public: to access the cluster from the laptop
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  # assign the cluster to a network
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # required for add-ons (e.g. karpenter, load balancer controller) role
  enable_irsa = true

  # choose one (managed node group, self managed node group, or fargate profile)
  # configuration below creates two managed node groups (general and spot)
  # to understand more: https://www.youtube.com/watch?v=xL-uAPn9znw
  eks_managed_node_group_defaults = {
    disk_size = 50
  }
  eks_managed_node_groups = {
    # master
    general = {
      desired_size = 2
      min_size     = 1
      max_size     = 10

      labels = {
        role = "general"
      }

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND" # not cheap, no interruptions

      iam_role_additional_policies = [
        # Required by Karpenter
        "arn:${local.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore"
      ]
    }

    # slave
    spot = {
      desired_size = 1
      min_size     = 1
      max_size     = 10

      labels = {
        role = "spot"
      }

      taints = [{
        key    = "market"
        value  = "spot"
        effect = "NO_SCHEDULE"
      }]

      instance_types = ["t3.micro"]
      capacity_type  = "SPOT" # cheap, risk of interruptions
    }
  }

  # map the eks-admin iam role with the Kubernetes system:masters RBAC group
  # with this, an iam user that assumes eks-admin iam role can access the cluster
  manage_aws_auth_configmap = true
  aws_auth_roles = [
    {
      rolearn  = module.eks_admins_iam_role.iam_role_arn
      username = module.eks_admins_iam_role.iam_role_name
      groups   = ["system:masters"]
    },
  ]

  # cluster security group (firewall)
  cluster_security_group_additional_rules = {
    # used in karpenter provisioner
    ingress_nodes_karpenter_ports_tcp = {
      description                = "Karpenter readiness"
      protocol                   = "tcp"
      from_port                  = 8443
      to_port                    = 8443
      type                       = "ingress"
      source_node_security_group = true
    }
  }

  # node security group (firewall)
  node_security_group_additional_rules = {
    # used in elb controller
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }

    # used in karpenter provisioner
    ingress_allow_karpenter_webhook_access_from_control_plane = {
      description                   = "Allow access from control plane to webhook port of karpenter"
      protocol                      = "tcp"
      from_port                     = 8443
      to_port                       = 8443
      type                          = "ingress"
      source_cluster_security_group = true
    }
  }

  tags = {
    Environment = var.environment
    "karpenter.sh/discovery" = var.cluster_name
  }
}

