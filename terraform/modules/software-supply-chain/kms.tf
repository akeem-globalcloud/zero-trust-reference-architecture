data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# Account-level key administration and IAM delegation.
data "aws_iam_policy_document" "kms_account_policy" {
  #checkov:skip=CKV_AWS_109:Account root retains KMS key administration to prevent loss of key-policy recovery and administration.
  #checkov:skip=CKV_AWS_111:KMS key administration is intentionally restricted to the owning AWS account root principal.
  #checkov:skip=CKV_AWS_356:KMS key policies use Resource "*" to represent the key to which the policy is attached.

  statement {
    sid    = "EnableAccountKeyAdministration"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions   = ["kms:*"]
    resources = ["*"]
  }
}

# CloudWatch Logs access restricted to this log group.
data "aws_iam_policy_document" "cloudwatch_kms_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.kms_account_policy.json
  ]

  statement {
    sid    = "AllowCloudWatchLogsEncryption"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.region}.amazonaws.com"]
    }

    actions = [
      "kms:CancelKeyDeletion",
      "kms:CreateGrant",
      "kms:DescribeKey",
      "kms:DisableKeyRotation",
      "kms:EnableKeyRotation",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:ListGrants",
      "kms:ListResourceTags",
      "kms:PutKeyPolicy",
      "kms:RevokeGrant",
      "kms:ScheduleKeyDeletion",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:UpdateKeyDescription"
    ]

    resources = ["*"]

    condition {
      test     = "ArnEquals"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = ["arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:${local.log_group_name}"]
    }
  }
}

# CodeArtifact customer-managed encryption key.
resource "aws_kms_key" "codeartifact" {
  description             = "ZT-012 CodeArtifact encryption key"
  enable_key_rotation     = true
  deletion_window_in_days = var.kms_deletion_window_days
  policy                  = data.aws_iam_policy_document.kms_account_policy.json

  tags = merge(local.common_tags, {
    Name = "${var.name_prefix}-codeartifact-key"
  })
}

resource "aws_kms_alias" "codeartifact" {
  name          = "alias/${var.name_prefix}-codeartifact"
  target_key_id = aws_kms_key.codeartifact.key_id
}

# CloudWatch customer-managed encryption key.
resource "aws_kms_key" "cloudwatch" {
  description             = "ZT-012 CloudWatch Logs encryption key"
  enable_key_rotation     = true
  deletion_window_in_days = var.kms_deletion_window_days
  policy                  = data.aws_iam_policy_document.cloudwatch_kms_policy.json

  tags = merge(local.common_tags, {
    Name = "${var.name_prefix}-cloudwatch-key"
  })
}

resource "aws_kms_alias" "cloudwatch" {
  name          = "alias/${var.name_prefix}-cloudwatch"
  target_key_id = aws_kms_key.cloudwatch.key_id
}

# Amazon ECR customer-managed encryption key.
resource "aws_kms_key" "ecr" {
  description             = "ZT-012 ECR artifact encryption key"
  enable_key_rotation     = true
  deletion_window_in_days = var.kms_deletion_window_days
  policy                  = data.aws_iam_policy_document.kms_account_policy.json

  tags = merge(local.common_tags, {
    Name = "${var.name_prefix}-ecr-key"
  })
}

resource "aws_kms_alias" "ecr" {
  name          = "alias/${var.name_prefix}-ecr"
  target_key_id = aws_kms_key.ecr.key_id
}
