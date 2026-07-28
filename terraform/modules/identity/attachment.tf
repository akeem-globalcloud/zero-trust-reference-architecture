############################################################
# Attach Module Policy
############################################################

resource "aws_iam_role_policy_attachment" "module_policy" {

  role = aws_iam_role.this.name

  policy_arn = aws_iam_policy.this.arn

}

############################################################
# Attach Managed Policies
############################################################

resource "aws_iam_role_policy_attachment" "managed" {

  for_each = toset(var.managed_policy_arns)

  role = aws_iam_role.this.name

  policy_arn = each.value

}
