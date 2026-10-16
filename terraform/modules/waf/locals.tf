###############################################################
# ZT-010 Enterprise Web Application Firewall
# Local Values
###############################################################

locals {
  waf_name = substr(
    lower(replace(var.name, "_", "-")),
    0,
    128
  )

  log_group_name = "aws-waf-logs-${local.waf_name}"

  common_tags = merge(
    {
      Project     = "Zero Trust Reference Architecture"
      Story       = "ZT-010"
      Capability  = "Enterprise Web Application Firewall"
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}
