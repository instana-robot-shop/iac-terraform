/**
  * aws
  * used to create aws resources
*/
provider "aws" {
  region = var.region[0]
}

/**
  * eks
  * used to connect to eks cluster
  * https://github.com/terraform-aws-modules/terraform-aws-eks/issues/2009
*/
data "aws_eks_cluster" "default" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  
  # connect to the cluster (way 1): use token which has an expiration time
  token                  = data.aws_eks_cluster_auth.default.token
    
  # connect to the cluster (way 2): retrieve token on each terraform run
  # apparently not working
  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.id]
  #   command     = "aws"
  # }
}

/**
  * kubectl
  * used to "kubectl apply {manifest_name}.yaml"
*/
provider "kubectl" {
  apply_retry_count      = 5
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  load_config_file       = false
  
  token                  = data.aws_eks_cluster_auth.default.token

  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.id]
  #   command     = "aws"
  # }
}

/**
  * helm
  * used to install helm charts on an eks cluster
*/
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.default.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
    
    # connect to the cluster (way 1): use token which has an expiration time
    token                  = data.aws_eks_cluster_auth.default.token
    
    # connect to the cluster (way 2): retrieve token on each terraform run
    # apparently not working
    # exec {
    #   api_version = "client.authentication.k8s.io/v1beta1"
    #   args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.id]
    #   command     = "aws"
    # }
  }
}