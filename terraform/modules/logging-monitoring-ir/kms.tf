resource "aws_kms_key" "logging" {
  description             = "KMS key for CloudTrail, CloudWatch Logs, SNS, and S3"
  deletion_window_in_days = var.kms_key_deletion_window
  enable_key_rotation     = true

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
