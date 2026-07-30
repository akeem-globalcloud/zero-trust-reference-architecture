resource "aws_cloudwatch_metric_alarm" "root_login" {

  alarm_name          = "${local.name_prefix}-root-login"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "RootAccountUsage"
  namespace           = "AWS/CloudTrail"
  period              = 300
  statistic           = "Sum"
  threshold           = 1

  alarm_description = "Root account usage detected."

  alarm_actions = var.enable_sns_notifications ? [aws_sns_topic.security[0].arn] : []

  tags = local.common_tags
}
