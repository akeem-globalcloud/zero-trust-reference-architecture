data "aws_iam_policy_document" "codebuild_assume_role" {
  statement {
    sid     = "AllowCodeBuildAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codebuild" {
  count = var.enable_codebuild ? 1 : 0

  name               = local.codebuild_role_name
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role.json
  description        = "Least-privilege service role for ZT-012 CodeBuild."

  tags = local.common_tags
}

#trivy:ignore:AVD-AWS-0057 CodeBuild generates dynamic log-stream names; access is restricted to this specific CloudWatch log group.
data "aws_iam_policy_document" "codebuild_permissions" {
  count = var.enable_codebuild ? 1 : 0

  statement {
    sid    = "CodeArtifactAuthentication"
    effect = "Allow"

    actions = [
      "codeartifact:GetAuthorizationToken"
    ]

    resources = [
      aws_codeartifact_domain.this.arn
    ]
  }

  statement {
    sid    = "CodeArtifactRepositoryAccess"
    effect = "Allow"

    actions = [
      "codeartifact:GetRepositoryEndpoint",
      "codeartifact:ReadFromRepository",
      "codeartifact:PublishPackageVersion",
      "codeartifact:PutPackageMetadata",
      "codeartifact:DescribeRepository"
    ]

    resources = [
      aws_codeartifact_repository.this.arn
    ]
  }

  statement {
    sid    = "CodeArtifactBearerToken"
    effect = "Allow"

    actions = [
      "sts:GetServiceBearerToken"
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "sts:AWSServiceName"
      values   = ["codeartifact.amazonaws.com"]
    }
  }

  statement {
    sid    = "ECRAuthentication"
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "ECRImageOperations"
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]

    resources = [
      aws_ecr_repository.artifacts.arn
    ]
  }

  statement {
    sid    = "CloudWatchBuildLogging"
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "${aws_cloudwatch_log_group.codebuild.arn}:log-stream:*"
    ]
  }
}

resource "aws_iam_role_policy" "codebuild" {
  count = var.enable_codebuild ? 1 : 0

  name   = "${local.resource_prefix}-codebuild-policy"
  role   = aws_iam_role.codebuild[0].id
  policy = data.aws_iam_policy_document.codebuild_permissions[0].json
}
