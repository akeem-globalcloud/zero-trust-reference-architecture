resource "aws_cloudwatch_log_group" "codebuild" {
  name              = local.log_group_name
  retention_in_days = var.log_retention_days
  kms_key_id        = aws_kms_key.cloudwatch.arn

  tags = local.common_tags
}

resource "aws_codebuild_project" "this" {
  count = var.enable_codebuild ? 1 : 0

  name          = local.codebuild_project_name
  description   = "ZT-012 enterprise software supply chain security build project."
  service_role  = aws_iam_role.codebuild[0].arn
  build_timeout = var.codebuild_timeout

  source {
    type            = "GITHUB"
    location        = var.github_repository_url
    git_clone_depth = 1
    buildspec       = var.buildspec
  }

  source_version = var.github_source_version

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = var.codebuild_compute_type
    image                       = var.codebuild_environment_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = var.codebuild_privileged_mode
  }

  logs_config {
    cloudwatch_logs {
      status      = "ENABLED"
      group_name  = aws_cloudwatch_log_group.codebuild.name
      stream_name = "build"
    }
  }

  tags = local.common_tags

  depends_on = [
    aws_iam_role_policy.codebuild
  ]
}
