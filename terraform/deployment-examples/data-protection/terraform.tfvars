aws_region = "us-east-1"

default_tags = {
  Environment = "dev"
  Project     = "zero-trust-reference-architecture"
  Owner       = "Akeem"
}

kms = {
  name        = "enterprise-kms-key"
  alias       = "enterprise-kms-key"
  description = "Enterprise KMS key for Zero Trust reference architecture"

  key_spec                 = "SYMMETRIC_DEFAULT"
  key_usage                = "ENCRYPT_DECRYPT"
  rotation_enabled         = true
  multi_region             = false
  deletion_window_in_days  = 30

  access = {
    administrators = []
    users          = []
    service_principals = [
      "s3.amazonaws.com"
    ]
  }

  additional_policy_documents = []

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "ZeroTrust"
  }
}
