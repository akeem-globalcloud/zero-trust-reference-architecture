############################################################
# Assume Role Policy Document
############################################################

data "aws_iam_policy_document" "assume_role" {

  statement {

    sid    = "AllowTrustedServices"
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {

      type = "Service"

      identifiers = var.trusted_services

    }

  }

}

############################################################
# Base IAM Policy
############################################################

data "aws_iam_policy_document" "base_policy" {

  statement {

    sid = "CloudWatchLogs"

    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["*"]

  }

}
