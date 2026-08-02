resource "aws_vpc_endpoint" "s3" {

  count = var.enable_vpc_endpoints ? 1 : 0

  vpc_id = aws_vpc.this.id

  service_name = "com.amazonaws.${var.aws_region}.s3"

  route_table_ids = [
    aws_route_table.private.id
  ]

  vpc_endpoint_type = "Gateway"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-s3-endpoint"
    }
  )
}
