resource "aws_iam_role" "this" {

  name = local.role_name

  description = var.role_description

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  permissions_boundary = var.permission_boundary_arn

  tags = local.common_tags

}
