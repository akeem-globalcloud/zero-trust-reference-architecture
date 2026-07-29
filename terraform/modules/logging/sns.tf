resource "aws_sns_topic" "security" {

  count = var.enable_sns_notifications ? 1 : 0

  name = "${local.name_prefix}-security-alerts"

  tags = local.common_tags
}
