###############################################################
# Security Hub
###############################################################

output "securityhub_account_id" {

  description = "AWS account where Security Hub is enabled."

  value = aws_securityhub_account.this.id

}

###############################################################
# SNS
###############################################################

output "sns_topic_arn" {

  value = try(aws_sns_topic.siem[0].arn, null)

}

###############################################################
# EventBridge
###############################################################

output "eventbridge_rule_name" {

  value = try(
    aws_cloudwatch_event_rule.securityhub[0].name,
    null
  )

}

###############################################################
# CloudWatch
###############################################################

output "cloudwatch_log_group" {

  value = aws_cloudwatch_log_group.siem.name

}

###############################################################
# IAM
###############################################################

output "eventbridge_role_arn" {

  value = aws_iam_role.eventbridge.arn

}

###############################################################
# KMS
###############################################################

output "kms_key_arn" {

  value = aws_kms_key.siem.arn

}

output "kms_key_alias" {

  value = aws_kms_alias.siem.name

}
