###############################################################
# Security Hub
###############################################################

output "securityhub_account_id" {

  value = module.siem.securityhub_account_id

}

###############################################################
# EventBridge
###############################################################

output "eventbridge_rule_name" {

  value = module.siem.eventbridge_rule_name

}

###############################################################
# SNS
###############################################################

output "sns_topic_arn" {

  value = module.siem.sns_topic_arn

}

###############################################################
# CloudWatch
###############################################################

output "cloudwatch_log_group" {

  value = module.siem.cloudwatch_log_group

}

###############################################################
# IAM
###############################################################

output "eventbridge_role_arn" {

  value = module.siem.eventbridge_role_arn

}

###############################################################
# KMS
###############################################################

output "kms_key_arn" {

  value = module.siem.kms_key_arn

}

output "kms_key_alias" {

  value = module.siem.kms_key_alias

}
