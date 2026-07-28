###############################################
# Default Application Security Group
###############################################

resource "aws_security_group" "application" {

  name = "${local.name_prefix}-application"

  description = "Application Security Group"

  vpc_id = aws_vpc.this.id

  ingress {

    from_port = 443

    to_port = 443

    protocol = "tcp"

    cidr_blocks = [
      var.vpc_cidr
    ]
  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-application"
    }
  )
}
