###############################################################
# ZT-010 Enterprise Web Application Firewall
# KMS Encryption for WAF CloudWatch Logs
###############################################################

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "waf_kms" {
  count = var.enable_logging ? 1 : 0

  statement {
    sid    = "AllowCloudWatchLogsUseOfKey"
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "logs.${data.aws_region.current.region}.amazonaws.com"
      ]
    }

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:ReEncrypt*"
    ]

    resources = ["*"]

    condition {
      test     = "ArnLike"
      variable = "kms:EncryptionContext:aws:logs:arn"

      values = [
        "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:${local.log_group_name}"
      ]
    }
  }
}

resource "aws_kms_key" "waf_logs" {
  count = var.enable_logging ? 1 : 0

  description         = "KMS key for Enterprise WAF CloudWatch Logs"
  enable_key_rotation = true

  policy = data.aws_iam_policy_document.waf_kms[0].json

  tags = local.common_tags
}

resource "aws_kms_alias" "waf_logs" {
  count = var.enable_logging ? 1 : 0

  name          = "alias/${local.waf_name}-logs"
  target_key_id = aws_kms_key.waf_logs[0].key_id
}
