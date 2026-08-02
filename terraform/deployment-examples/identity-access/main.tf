module "identity" {

  source = "../../modules/identity"

  project_name = "ztra"

  environment = "dev"

  role_name = "application"

  role_description = "Example application role"

  trusted_services = [

    "ec2.amazonaws.com"

  ]

  managed_policy_arns = [

    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

  ]

  tags = {

    Owner = "Platform Engineering"

    Repository = "zero-trust-reference-architecture"

  }

}
