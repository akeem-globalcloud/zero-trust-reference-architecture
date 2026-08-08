###############################################################
# Data Sources
###############################################################

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

###############################################################
# KMS Key Policy
###############################################################

data "aws_iam_policy_document" "kms" {

  statement {

    sid    = "EnableRootAdministration"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    actions = [
      "kms:*"
    ]

    resources = [
      "*"
    ]
  }

  statement {

    sid    = "AllowSecurityHub"
    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "securityhub.amazonaws.com"
      ]
    }

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = [
      "*"
    ]
  }

  statement {

    sid    = "AllowEventBridge"
    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "events.amazonaws.com"
      ]
    }

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = [
      "*"
    ]
  }

  statement {

    sid    = "AllowSNS"
    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "sns.amazonaws.com"
      ]
    }

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = [
      "*"
    ]

    condition {

      test     = "StringEquals"
      variable = "kms:CallerAccount"

      values = [
        data.aws_caller_identity.current.account_id
      ]
    }

    condition {

      test     = "StringEquals"
      variable = "kms:ViaService"

      values = [
        "sns.${data.aws_region.current.region}.amazonaws.com"
      ]
    }
  }
}

###############################################################
# Customer Managed KMS Key
###############################################################

resource "aws_kms_key" "siem" {

  description             = "Enterprise SIEM encryption key"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  policy = data.aws_iam_policy_document.kms.json

  tags = local.common_tags
}

###############################################################
# KMS Alias
###############################################################

resource "aws_kms_alias" "siem" {

  name = "alias/${var.siem.name}-siem"

  target_key_id = aws_kms_key.siem.key_id
}
