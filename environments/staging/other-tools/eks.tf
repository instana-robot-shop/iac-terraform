module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name    = "my-eks"
  cluster_version = "1.23"

  # cluster endpoint private: to access the cluster from a bastion host or vpn
  # cluster endpoint public: to access the cluster from the laptop
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  # assign the cluster to a network
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  #
  enable_irsa = true

  # choose one (managed node group, self managed node group, or fargate profile)
  # configuration below creates two managed node groups (general and spot)
  eks_managed_node_group_defaults = {
    disk_size = 50
  }
  eks_managed_node_groups = {
    general = {
      desired_size = 1
      min_size     = 1
      max_size     = 10

      labels = {
        role = "general"
      }

      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
    }

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
      capacity_type  = "SPOT"
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

  # eks nodes security group (firewall) - to authenticate which can access the nodes
  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
  }

  tags = {
    Environment = var.environment
  }
}

