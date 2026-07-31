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

  #
  # Create new CloudWatch Log Groups
  #
  statement {

    sid    = "CreateLogGroup"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup"
    ]

    resources = [
      "*"
    ]

  }

  #
  # Write to CloudWatch Log Groups
  #
  statement {

    sid    = "WriteCloudWatchLogs"
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:*:*:log-group:*",
      "arn:aws:logs:*:*:log-group:*:log-stream:*"
    ]

  }

}
