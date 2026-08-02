#############################################################
# Story 4.1 (v0.4.1)
# Detection, Monitoring & Incident Response
# CloudTrail IAM Role
#############################################################

#############################################
# IAM Assume Role Policy
#############################################

data "aws_iam_policy_document" "cloudtrail_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

#############################################
# IAM Role
#############################################

resource "aws_iam_role" "cloudtrail_logs" {
  name               = "${local.name_prefix}-cloudtrail-logs-role"
  assume_role_policy = data.aws_iam_policy_document.cloudtrail_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name      = "${local.name_prefix}-cloudtrail-logs-role"
      Component = "IAM"
    }
  )
}

#############################################
# IAM Policy
#############################################

data "aws_iam_policy_document" "cloudtrail_logs" {

  statement {
    sid    = "AllowCloudWatchLogs"
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
    ]
  }
}

#############################################
# IAM Role Policy
#############################################

resource "aws_iam_role_policy" "cloudtrail_logs" {
  name   = "${local.name_prefix}-cloudtrail-logs-policy"
  role   = aws_iam_role.cloudtrail_logs.id
  policy = data.aws_iam_policy_document.cloudtrail_logs.json
}
