###############################################################
# CloudWatch Log Group
###############################################################

resource "aws_cloudwatch_log_group" "siem" {

  name = "/aws/security/${var.siem.name}"

  retention_in_days = 365

  kms_key_id = aws_kms_key.siem.arn

  tags = local.common_tags

}
