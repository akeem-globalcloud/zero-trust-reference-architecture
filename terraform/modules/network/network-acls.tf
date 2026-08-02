resource "aws_network_acl" "private" {

  vpc_id = aws_vpc.this.id

  subnet_ids = aws_subnet.private[*].id

  ingress {

    protocol = "tcp"

    rule_no = 100

    action = "allow"

    cidr_block = var.vpc_cidr

    from_port = 0

    to_port = 65535
  }

  egress {

    protocol = "-1"

    rule_no = 100

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 0

    to_port = 0
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-private-acl"
    }
  )
}
