###############################################################
# ZT-010 Enterprise Web Application Firewall
# Deployment Example
###############################################################

module "waf" {
  source = "../../modules/waf"

  aws_region = var.aws_region

  name           = var.name
  scope          = var.scope
  default_action = var.default_action

  enable_rate_limit = var.enable_rate_limit
  rate_limit        = var.rate_limit

  managed_rule_groups = var.managed_rule_groups

  blocked_ip_addresses = var.blocked_ip_addresses
  allowed_ip_addresses = var.allowed_ip_addresses

  enable_logging     = var.enable_logging
  log_retention_days = var.log_retention_days

  tags = var.tags
}
