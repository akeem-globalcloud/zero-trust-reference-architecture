output "cloudtrail_name" {
  value = try(aws_cloudtrail.this[0].name, null)
}

output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.cloudtrail.name
}

output "sns_topic_arn" {
  value = try(aws_sns_topic.security[0].arn, null)
}

output "dashboard_name" {
  value = aws_cloudwatch_dashboard.security.dashboard_name
}

#############################################################
# Outputs
#############################################################

output "inspector_account_id" {
  description = "AWS Account enabled for Amazon Inspector."
  value       = data.aws_caller_identity.current.account_id
}

output "inspector_enabled_resource_types" {
  description = "Inspector enabled resource types."

  value = [
    "EC2",
    "ECR",
    "LAMBDA"
  ]
}

output "inspector_status" {
  description = "Amazon Inspector deployment status."
  value       = "Enabled"
}

output "eventbridge_bus_name" {
  description = "Security EventBridge bus."
  value       = aws_cloudwatch_event_bus.security.name
}

output "eventbridge_bus_arn" {
  description = "ARN of the security EventBridge bus."
  value       = aws_cloudwatch_event_bus.security.arn
}

output "organization_trail_name" {
  description = "Organization CloudTrail name."

  value = var.enable_organization_trail ? aws_cloudtrail.organization[0].name : null
}

output "organization_trail_arn" {
  description = "Organization CloudTrail ARN."

  value = var.enable_organization_trail ? aws_cloudtrail.organization[0].arn : null
}

output "cloudtrail_log_file_validation_enabled" {
  description = "CloudTrail log file validation status."
  value       = var.enable_log_file_validation
}

output "security_dashboard_name" {
  description = "CloudWatch Security Operations Dashboard."

  value = aws_cloudwatch_dashboard.security_operations.dashboard_name
}

output "logging_kms_key_arn" {
  description = "ARN of the logging KMS key."
  value       = aws_kms_key.logging.arn
}

output "logging_kms_key_id" {
  description = "ID of the logging KMS key."
  value       = aws_kms_key.logging.key_id
}
