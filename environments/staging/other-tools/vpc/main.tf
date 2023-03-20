module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "other-tools-vpc"
  cidr = "10.0.0.0/16"

  # inside 2 azs, create two private subnets and two public subnets each 
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # 
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  # one nat gateway per subnet 
  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = false

  # enable internet gateway
  create_igw = true

  # dns hostname are used to map the private ip addresses of ec2 instances and other resources within the vpc to human-readable domain names
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform = "true"
    Environment = var.environment
  }
}

