###############################################################
# ZT-010 Enterprise Web Application Firewall
# Deployment Outputs
###############################################################

output "web_acl_id" {
  description = "WAF Web ACL ID."
  value       = module.waf.web_acl_id
}

output "web_acl_arn" {
  description = "WAF Web ACL ARN."
  value       = module.waf.web_acl_arn
}

output "web_acl_name" {
  description = "WAF Web ACL name."
  value       = module.waf.web_acl_name
}

output "web_acl_scope" {
  description = "WAF Web ACL scope."
  value       = module.waf.web_acl_scope
}

output "blocked_ip_set_arn" {
  description = "Blocked IP set ARN."
  value       = module.waf.blocked_ip_set_arn
}

output "allowed_ip_set_arn" {
  description = "Allowed IP set ARN."
  value       = module.waf.allowed_ip_set_arn
}

output "waf_log_group_arn" {
  description = "WAF CloudWatch Log Group ARN."
  value       = module.waf.waf_log_group_arn
}

output "waf_logging_configuration_id" {
  description = "WAF logging configuration ID."
  value       = module.waf.waf_logging_configuration_id
}
