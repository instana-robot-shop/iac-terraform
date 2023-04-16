module "vpc" {
  count = var.environment != "dev" ? 1 : 0

  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.3"

  name = "main"

  # 
  cidr = "10.0.0.0/16"

  # inside 2 azs, create two private subnets and two public subnets each 
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
  public_subnets  = ["10.0.64.0/19", "10.0.96.0/19"]
  
  #
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    # Tags subnets for ELB
    "kubernetes.io/role/internal-elb" = "1"

    "kubernetes.io/cluster/${var.cluster_name}" = "owned"

    # Tags subnets for Karpenter auto-discovery
    "karpenter.sh/discovery" = var.cluster_name
  }

  # one nat gateway per subnet but not per az
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  # dns hostname are used to map the private ip addresses of ec2 instances and other resources within the vpc to human-readable domain names
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = var.environment
  }
}

