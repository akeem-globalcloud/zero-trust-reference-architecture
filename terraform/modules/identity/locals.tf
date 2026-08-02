locals {

  resource_prefix = lower(
    "${var.project_name}-${var.environment}"
  )

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Repository  = "zero-trust-reference-architecture"
      Module      = "identity"
    },
    var.tags
  )

}
