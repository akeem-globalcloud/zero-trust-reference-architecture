###############################################################
# EventBridge Rule
###############################################################

resource "aws_cloudwatch_event_rule" "securityhub" {

  count = var.siem.eventbridge.enabled ? 1 : 0

  name        = "${var.siem.name}-securityhub-findings"
  description = "Routes Security Hub findings."

  event_pattern = jsonencode({

    source = [
      "aws.securityhub"
    ]

    detail-type = [
      "Security Hub Findings - Imported"
    ]

  })

  tags = local.common_tags
}

###############################################################
# EventBridge Target
###############################################################

resource "aws_cloudwatch_event_target" "sns" {

  count = (
    var.siem.eventbridge.enabled &&
    var.siem.sns.enabled
  ) ? 1 : 0

  rule = aws_cloudwatch_event_rule.securityhub[0].name

  arn = aws_sns_topic.siem[0].arn

  role_arn = aws_iam_role.eventbridge.arn

}
