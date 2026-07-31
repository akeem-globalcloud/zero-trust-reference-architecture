resource "aws_cloudwatch_log_group" "vpc_flow_logs" {

  name              = "/aws/vpc/${local.name_prefix}/flow-logs"
  retention_in_days = 90

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpc-flow-logs"
    }
  )
}

resource "aws_flow_log" "this" {

  vpc_id = aws_vpc.this.id

  traffic_type = "ALL"

  log_destination_type = "cloud-watch-logs"

  log_group_name = aws_cloudwatch_log_group.vpc_flow_logs.name

  iam_role_arn = aws_iam_role.vpc_flow_logs.arn

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpc-flow-logs"
    }
  )
}
