resource "aws_kms_key" "vpc_flow_logs" {

  description             = "KMS key for VPC Flow Logs"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpc-flow-logs-kms"
    }
  )
}

resource "aws_kms_alias" "vpc_flow_logs" {

  name = "alias/${local.name_prefix}-vpc-flow-logs"

  target_key_id = aws_kms_key.vpc_flow_logs.key_id
}
