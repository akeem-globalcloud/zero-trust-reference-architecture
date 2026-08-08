###############################################################
# EventBridge Assume Role Policy
###############################################################

data "aws_iam_policy_document" "eventbridge_assume_role" {

  statement {

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "events.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

###############################################################
# IAM Role
###############################################################

resource "aws_iam_role" "eventbridge" {

  name = "${var.siem.name}-eventbridge-role"

  assume_role_policy = data.aws_iam_policy_document.eventbridge_assume_role.json

  tags = local.common_tags
}

###############################################################
# IAM Policy
###############################################################

data "aws_iam_policy_document" "eventbridge" {

  statement {

    sid = "PublishToSNS"

    effect = "Allow"

    actions = [
      "sns:Publish"
    ]

    resources = [
      aws_sns_topic.siem[0].arn
    ]
  }

  statement {

    sid = "UseKMSKey"

    effect = "Allow"

    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey",
      "kms:DescribeKey"
    ]

    resources = [
      aws_kms_key.siem.arn
    ]
  }
}

###############################################################
# IAM Policy Resource
###############################################################

resource "aws_iam_policy" "eventbridge" {

  name = "${var.siem.name}-eventbridge-policy"

  description = "Allows EventBridge to publish Security Hub findings to SNS."

  policy = data.aws_iam_policy_document.eventbridge.json

  tags = local.common_tags
}

###############################################################
# Attach Policy
###############################################################

resource "aws_iam_role_policy_attachment" "eventbridge" {

  role = aws_iam_role.eventbridge.name

  policy_arn = aws_iam_policy.eventbridge.arn
}
