###############################################################
# ZT-010 Enterprise Web Application Firewall
# WAF Logging and CloudWatch Resource Policy
###############################################################

resource "aws_cloudwatch_log_group" "waf" {
  count = var.enable_logging ? 1 : 0

  name              = local.log_group_name
  retention_in_days = var.log_retention_days
  kms_key_id        = aws_kms_key.waf_logs[0].arn
  tags = local.common_tags
}



data "aws_iam_policy_document" "waf_logging" {
  count = var.enable_logging ? 1 : 0

  statement {
    sid    = "AWSWAFLogging"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "${aws_cloudwatch_log_group.waf[0].arn}:*"
    ]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"

      values = [
        "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:*"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"

      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "waf" {
  count = var.enable_logging ? 1 : 0

  policy_name     = "${local.waf_name}-logging-policy"
  policy_document = data.aws_iam_policy_document.waf_logging[0].json
}

resource "aws_wafv2_web_acl_logging_configuration" "this" {
  count = var.enable_logging ? 1 : 0

  resource_arn = aws_wafv2_web_acl.this.arn

  log_destination_configs = [
    aws_cloudwatch_log_group.waf[0].arn
  ]

  depends_on = [
    aws_cloudwatch_log_resource_policy.waf
  ]
}
