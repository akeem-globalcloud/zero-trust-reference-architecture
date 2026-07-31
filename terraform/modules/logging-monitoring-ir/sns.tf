resource "aws_sns_topic" "security" {
  
  count = var.enable_sns_notifications ? 1 : 0

  name              = "${local.name_prefix}-security-alerts"
  kms_master_key_id = aws_kms_key.logging.arn

  tags = merge(
    local.common_tags,
    {
      Name      = "${local.name_prefix}-security-alerts"
      Component = "SNS"
    }
  )
}
