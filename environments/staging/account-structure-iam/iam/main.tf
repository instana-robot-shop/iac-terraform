/**
  * create users, and roles 
  * attach policies to users and roles
*/
module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name          = "renz"
  force_destroy = true

  pgp_key = "keybase:test"

  password_reset_required = false
}

// roles with predefined policies
module "iam_assumable_roles" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::835367859851:user/renz",
  ]

  create_admin_role = true
}

/**
  * create users, groups 
  * attach/create policies to users, and groups
*/







