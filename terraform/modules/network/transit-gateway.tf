resource "aws_ec2_transit_gateway" "this" {

  description = "${local.name_prefix} Transit Gateway"

  amazon_side_asn = 64512

  default_route_table_association = "enable"

  default_route_table_propagation = "enable"

  dns_support = "enable"

  vpn_ecmp_support = "enable"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-tgw"
    }
  )
}
