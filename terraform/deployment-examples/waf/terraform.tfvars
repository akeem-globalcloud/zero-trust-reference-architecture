###############################################################
# ZT-010 Enterprise Web Application Firewall
###############################################################

aws_region = "us-east-1"

name = "enterprise-waf"

scope = "REGIONAL"

default_action = "ALLOW"

enable_rate_limit = true

rate_limit = 2000

managed_rule_groups = [
  {
    name     = "AWSManagedRulesCommonRuleSet"
    vendor   = "AWS"
    priority = 10
  },
  {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    vendor   = "AWS"
    priority = 20
  },
  {
    name     = "AWSManagedRulesSQLiRuleSet"
    vendor   = "AWS"
    priority = 30
  }
]

blocked_ip_addresses = []

allowed_ip_addresses = []

enable_logging = true

log_retention_days = 365

tags = {
  Environment = "Production"
  Owner       = "Cloud Security"
  Project     = "Zero Trust Reference Architecture"
  Story       = "ZT-010"
  Capability  = "Enterprise Web Application Firewall"
}
