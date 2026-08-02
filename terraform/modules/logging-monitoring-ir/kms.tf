resource "aws_kms_key" "logging" {

  description             = "KMS key for CloudTrail, CloudWatch Logs, SNS, and S3"
  deletion_window_in_days = var.kms_key_deletion_window
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [

      {
        Sid    = "EnableRootPermissions"
        Effect = "Allow"

        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }

        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })

  tags = merge(
    local.common_tags,
    {
      Name      = "${local.name_prefix}-logging-kms"
      Component = "KMS"
    }
  )
}
  