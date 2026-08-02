data "aws_iam_policy_document" "secret" {

  count = var.secret.resource_policy.enabled ? 1 : 0

  statement {

    sid    = "AllowSecretAccess"
    effect = "Allow"

    principals {

      type = "AWS"

      identifiers = var.secret.resource_policy.principals

    }

    actions = var.secret.resource_policy.actions

    resources = [
      aws_secretsmanager_secret.this.arn
    ]

  }

}

resource "aws_secretsmanager_secret_policy" "this" {

  count = var.secret.resource_policy.enabled ? 1 : 0

  secret_arn = aws_secretsmanager_secret.this.arn

  policy = data.aws_iam_policy_document.secret[0].json

}
