#############################################################
# Story 4.1 (v0.4.1)
# Detection, Monitoring & Incident Response
# CloudWatch Metric Filters
#############################################################

#############################################
# Root Account Usage
#############################################

resource "aws_cloudwatch_log_metric_filter" "root_account_usage" {
  name           = "${local.name_prefix}-root-account-usage"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  pattern = "{ ($.userIdentity.type = Root) && ($.userIdentity.invokedBy NOT EXISTS) }"

  metric_transformation {
    name      = "RootAccountUsage"
    namespace = "ZeroTrust/Security"
    value     = "1"
  }
}

#############################################
# Unauthorized API Calls
#############################################

resource "aws_cloudwatch_log_metric_filter" "unauthorized_api_calls" {
  name           = "${local.name_prefix}-unauthorized-api-calls"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  pattern = "{ ($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\") }"

  metric_transformation {
    name      = "UnauthorizedApiCalls"
    namespace = "ZeroTrust/Security"
    value     = "1"
  }
}

#############################################
# Console Login Failures
#############################################

resource "aws_cloudwatch_log_metric_filter" "console_login_failure" {
  name           = "${local.name_prefix}-console-login-failure"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  pattern = "{ ($.eventName = ConsoleLogin) && ($.errorMessage = \"Failed authentication\") }"

  metric_transformation {
    name      = "ConsoleLoginFailure"
    namespace = "ZeroTrust/Security"
    value     = "1"
  }
}

#############################################
# IAM Policy Changes
#############################################

resource "aws_cloudwatch_log_metric_filter" "iam_policy_changes" {
  name           = "${local.name_prefix}-iam-policy-changes"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  pattern = "{ ($.eventSource = iam.amazonaws.com) && (($.eventName = CreatePolicy) || ($.eventName = DeletePolicy) || ($.eventName = CreatePolicyVersion) || ($.eventName = DeletePolicyVersion) || ($.eventName = AttachRolePolicy) || ($.eventName = DetachRolePolicy)) }"

  metric_transformation {
    name      = "IAMPolicyChanges"
    namespace = "ZeroTrust/Security"
    value     = "1"
  }
}

#############################################
# Security Group Changes
#############################################

resource "aws_cloudwatch_log_metric_filter" "security_group_changes" {
  name           = "${local.name_prefix}-security-group-changes"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  pattern = "{ ($.eventSource = ec2.amazonaws.com) && (($.eventName = AuthorizeSecurityGroupIngress) || ($.eventName = RevokeSecurityGroupIngress) || ($.eventName = AuthorizeSecurityGroupEgress) || ($.eventName = RevokeSecurityGroupEgress)) }"

  metric_transformation {
    name      = "SecurityGroupChanges"
    namespace = "ZeroTrust/Security"
    value     = "1"
  }
}

#############################################
# CloudTrail Configuration Changes
#############################################

resource "aws_cloudwatch_log_metric_filter" "cloudtrail_changes" {
  name           = "${local.name_prefix}-cloudtrail-configuration-changes"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  pattern = "{ ($.eventSource = cloudtrail.amazonaws.com) && (($.eventName = StopLogging) || ($.eventName = DeleteTrail) || ($.eventName = UpdateTrail)) }"

  metric_transformation {
    name      = "CloudTrailConfigurationChanges"
    namespace = "ZeroTrust/Security"
    value     = "1"
  }
}

#############################################
# KMS Key Deletion
#############################################

resource "aws_cloudwatch_log_metric_filter" "kms_key_deletion" {
  name           = "${local.name_prefix}-kms-key-deletion"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  pattern = "{ ($.eventSource = kms.amazonaws.com) && ($.eventName = ScheduleKeyDeletion) }"

  metric_transformation {
    name      = "KMSKeyDeletion"
    namespace = "ZeroTrust/Security"
    value     = "1"
  }
}
