resource "aws_iam_policy" "this" {

  name        = local.policy_name

  description = "Identity module policy"

  policy = data.aws_iam_policy_document.base_policy.json

  tags = local.common_tags

}
