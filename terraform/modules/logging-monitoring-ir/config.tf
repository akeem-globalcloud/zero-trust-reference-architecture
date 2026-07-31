resource "aws_config_configuration_recorder" "this" {

  count = var.enable_config ? 1 : 0

  name     = "${local.name_prefix}-config"
  role_arn = aws_iam_role.config[0].arn

  recording_group {
    all_supported = true

    include_global_resource_types = true
  }
}

resource "aws_iam_role" "config" {

  count = var.enable_config ? 1 : 0

  name = "${local.name_prefix}-config-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "config.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })

  tags = local.common_tags
}
