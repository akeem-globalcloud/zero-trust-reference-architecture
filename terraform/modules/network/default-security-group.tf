###############################################
# Default Security Group
###############################################

resource "aws_default_security_group" "default" {

  vpc_id = aws_vpc.this.id

  revoke_rules_on_delete = true

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-default-security-group"
    }
  )
}
