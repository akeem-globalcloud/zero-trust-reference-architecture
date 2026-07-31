data "aws_iam_policy_document" "vpc_flow_logs_assume_role" {

  statement {

    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "vpc-flow-logs.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "vpc_flow_logs" {

  name = "${local.name_prefix}-vpc-flow-logs-role"

  assume_role_policy = data.aws_iam_policy_document.vpc_flow_logs_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpc-flow-logs-role"
    }
  )
}

data "aws_iam_policy_document" "vpc_flow_logs" {

  statement {

    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy" "vpc_flow_logs" {

  name = "${local.name_prefix}-vpc-flow-logs-policy"

  role = aws_iam_role.vpc_flow_logs.id

  policy = data.aws_iam_policy_document.vpc_flow_logs.json
}
