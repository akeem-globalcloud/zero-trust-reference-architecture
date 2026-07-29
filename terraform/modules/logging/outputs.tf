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
