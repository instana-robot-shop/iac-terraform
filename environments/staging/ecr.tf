/**
  * create public ecr repositories
  * single repository per microservice app 
*/
module "ecr" {
  for_each = toset(var.microservice_apps)

  source = "terraform-aws-modules/ecr/aws"

  repository_name = each.value
  repository_type = "public"
  repository_image_scan_on_push = true #
  
  # Always retain only the last 30 images i.e. in our case, the last 30 versions of the microservice app
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          # tagStatus     = "tagged",
          # tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}






