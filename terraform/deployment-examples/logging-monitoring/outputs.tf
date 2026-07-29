output "cloudtrail_name" {
  value = module.logging.cloudtrail_name
}

output "cloudwatch_log_group" {
  value = module.logging.cloudwatch_log_group
}

output "dashboard_name" {
  value = module.logging.dashboard_name
}

output "sns_topic_arn" {
  value = module.logging.sns_topic_arn
}
