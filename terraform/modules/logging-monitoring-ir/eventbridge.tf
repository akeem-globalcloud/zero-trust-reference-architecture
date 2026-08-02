#############################################################
# Story 4.1 (v0.4.1)
# Detection, Monitoring & Incident Response
# Amazon EventBridge
#############################################################

#############################################
# Event Bus
#############################################

resource "aws_cloudwatch_event_bus" "security" {
  name = "${local.name_prefix}-security-bus"

  tags = merge(
    var.tags,
    {
      Name      = "${local.name_prefix}-security-bus"
      Component = "EventBridge"
      Story     = "4.1"
    }
  )
}

#############################################
# Security Hub Findings
#############################################

resource "aws_cloudwatch_event_rule" "securityhub_findings" {
  name        = "${local.name_prefix}-securityhub-findings"
  description = "Capture AWS Security Hub findings."

  event_pattern = jsonencode({
    source = ["aws.securityhub"]

    detail-type = [
      "Security Hub Findings - Imported"
    ]
  })

  event_bus_name = aws_cloudwatch_event_bus.security.name
}

#############################################
# Amazon Inspector Findings
#############################################

resource "aws_cloudwatch_event_rule" "inspector_findings" {
  name        = "${local.name_prefix}-inspector-findings"
  description = "Capture Amazon Inspector findings."

  event_pattern = jsonencode({
    source = ["aws.inspector2"]

    detail-type = [
      "Inspector2 Finding"
    ]
  })

  event_bus_name = aws_cloudwatch_event_bus.security.name
}

#############################################
# AWS Config Compliance Changes
#############################################

resource "aws_cloudwatch_event_rule" "config_changes" {
  name        = "${local.name_prefix}-config-compliance"
  description = "Capture AWS Config compliance changes."

  event_pattern = jsonencode({
    source = ["aws.config"]

    detail-type = [
      "Config Rules Compliance Change"
    ]
  })

  event_bus_name = aws_cloudwatch_event_bus.security.name
}

#############################################
# CloudTrail Security Events
#############################################

resource "aws_cloudwatch_event_rule" "cloudtrail_security" {
  name        = "${local.name_prefix}-cloudtrail-security-events"
  description = "Capture CloudTrail API activity."

  event_pattern = jsonencode({
    source = [
      "aws.cloudtrail"
    ]
  })

  event_bus_name = aws_cloudwatch_event_bus.security.name
}

#############################################
# SNS Targets
#############################################

resource "aws_cloudwatch_event_target" "sns_securityhub" {
  rule           = aws_cloudwatch_event_rule.securityhub_findings.name
  event_bus_name = aws_cloudwatch_event_bus.security.name
  arn            = aws_sns_topic.security[0].arn
}

resource "aws_cloudwatch_event_target" "sns_inspector" {
  rule           = aws_cloudwatch_event_rule.inspector_findings.name
  event_bus_name = aws_cloudwatch_event_bus.security.name
  arn            = aws_sns_topic.security[0].arn
}

resource "aws_cloudwatch_event_target" "sns_config" {
  rule           = aws_cloudwatch_event_rule.config_changes.name
  event_bus_name = aws_cloudwatch_event_bus.security.name
  arn            = aws_sns_topic.security[0].arn
}

resource "aws_cloudwatch_event_target" "sns_cloudtrail" {
  rule           = aws_cloudwatch_event_rule.cloudtrail_security.name
  event_bus_name = aws_cloudwatch_event_bus.security.name
  arn            = aws_sns_topic.security[0].arn
}
