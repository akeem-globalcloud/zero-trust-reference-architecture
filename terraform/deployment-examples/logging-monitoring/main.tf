module "logging" {
  source = "../../modules/logging-monitoring-ir"

  ###########################################################
  # Story 4.0 Logging & Monitoring
  ###########################################################

  aws_region   = var.aws_region
  project_name = var.project_name
  environment  = var.environment

  enable_cloudtrail        = true
  enable_config            = true
  enable_securityhub       = true
  enable_sns_notifications = true

  log_retention_days = 365

  ###########################################################
  # Story 4.1 Configuration
  ###########################################################

  cloudtrail_bucket_name     = var.cloudtrail_bucket_name
  enable_log_file_validation = true
  enable_organization_trail  = false

  enable_delegated_admin            = false
  delegated_admin_account_id        = ""
  enable_organization_configuration = false

  ###########################################################
  # Tags
  ###########################################################

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = "Cloud Security"
  }
}
