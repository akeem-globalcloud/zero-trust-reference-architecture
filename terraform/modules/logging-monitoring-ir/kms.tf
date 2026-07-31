data "aws_iam_policy_document" "kms_logging" {
  statement {
    sid    = "EnableRootPermissions"
    effect = "Allow"

    principals {
      type        = "AWS"
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
    sid    = "AllowCloudTrailCloudWatchSNSS3"
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com",
        "logs.amazonaws.com",
        "sns.amazonaws.com",
        "s3.amazonaws.com"
      ]
    }

    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyWithoutPlaintext",
      "kms:ReEncrypt*"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_kms_key" "logging" {
  description             = "KMS key for CloudTrail, CloudWatch Logs, SNS, and S3"
  deletion_window_in_days = var.kms_key_deletion_window
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms_logging.json

  tags = merge(
    local.common_tags,
    {
      Name      = "${local.name_prefix}-logging-kms"
      Component = "KMS"
    }
  )
}

resource "aws_kms_alias" "logging" {
  name          = "alias/${local.name_prefix}-logging"
  target_key_id = aws_kms_key.logging.key_id
}
