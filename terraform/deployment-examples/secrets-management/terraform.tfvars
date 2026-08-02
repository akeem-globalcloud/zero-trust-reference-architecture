aws_region = "us-east-1"

secret = {

  name        = "enterprise/application/database"
  description = "Database credentials for enterprise application"

  kms_key_id = null

  recovery_window_in_days = 30

  secret = {

    username = "dbadmin"

    password = "ChangeMe123!"

  }

  force_overwrite_replica_secret = false

  tags = {

    Environment = "Development"
    Project     = "ZeroTrust"
    ManagedBy   = "Terraform"

  }

  rotation = {

    enabled                  = false
    lambda_arn               = null
    automatically_after_days = 30

  }

  resource_policy = {

    enabled    = false
    principals = []
    actions    = ["secretsmanager:GetSecretValue"]

  }

  replica_regions = []

}
