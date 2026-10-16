###############################################################
# ZT-010 Enterprise Web Application Firewall
# Module Outputs
###############################################################

output "web_acl_id" {
  description = "ID of the WAF Web ACL."
  value       = aws_wafv2_web_acl.this.id
}

output "web_acl_arn" {
  description = "ARN of the WAF Web ACL."
  value       = aws_wafv2_web_acl.this.arn
}

output "web_acl_name" {
  description = "Name of the WAF Web ACL."
  value       = aws_wafv2_web_acl.this.name
}

output "web_acl_scope" {
  description = "Scope of the WAF Web ACL."
  value       = aws_wafv2_web_acl.this.scope
}

output "blocked_ip_set_arn" {
  description = "ARN of the blocked IP set, when configured."
  value       = try(aws_wafv2_ip_set.blocked[0].arn, null)
}

output "allowed_ip_set_arn" {
  description = "ARN of the allowed IP set, when configured."
  value       = try(aws_wafv2_ip_set.allowed[0].arn, null)
}

output "waf_log_group_arn" {
  description = "ARN of the WAF CloudWatch Log Group, when logging is enabled."
  value       = try(aws_cloudwatch_log_group.waf[0].arn, null)
}

output "waf_logging_configuration_id" {
  description = "WAF logging configuration ID, when logging is enabled."
  value       = try(aws_wafv2_web_acl_logging_configuration.this[0].id, null)
}
