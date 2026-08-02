#############################################################
# Deployment Outputs
# Story 4.1
#############################################################

output "cloudtrail_name" {
  description = "CloudTrail trail name."
  value       = module.logging.cloudtrail_name
}

output "cloudwatch_log_group" {
  description = "CloudWatch Log Group."
  value       = module.logging.cloudwatch_log_group
}

output "security_dashboard_name" {
  description = "CloudWatch Security Operations Dashboard."
  value       = module.logging.security_dashboard_name
}

output "sns_topic_arn" {
  description = "SNS Topic ARN."
  value       = module.logging.sns_topic_arn
}

output "eventbridge_bus_name" {
  description = "Amazon EventBridge security event bus."
  value       = module.logging.eventbridge_bus_name
}

output "inspector_status" {
  description = "Amazon Inspector deployment status."
  value       = module.logging.inspector_status
}

output "organization_trail_name" {
  description = "Organization CloudTrail (if enabled)."
  value       = module.logging.organization_trail_name
}

output "cloudtrail_log_file_validation_enabled" {
  description = "CloudTrail log file validation status."
  value       = module.logging.cloudtrail_log_file_validation_enabled
}
