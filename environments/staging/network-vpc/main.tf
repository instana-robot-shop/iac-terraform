/**
  * create vpc network
  * create inside vpc network: internet gateway, route tables, subnets, nat gateway, network interface (attach eip)
*/
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  # inside 2 azs, create two private subnets and two public subnets each 
  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # one nat gateway per subnet 
  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = false

  # enable internet gateway internet gateway 
  create_igw = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

