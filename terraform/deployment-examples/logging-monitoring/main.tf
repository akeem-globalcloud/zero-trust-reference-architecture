module "logging" {
  source = "../../modules/logging"

  aws_region   = var.aws_region
  project_name = var.project_name
  environment  = var.environment

  enable_cloudtrail        = true
  enable_config            = true
  enable_securityhub       = true
  enable_sns_notifications = true

  log_retention_days = 365

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = "Cloud Security"
  }
}
