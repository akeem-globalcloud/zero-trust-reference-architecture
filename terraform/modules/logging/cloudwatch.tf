resource "aws_cloudwatch_dashboard" "security" {

  dashboard_name = "${local.name_prefix}-dashboard"

  dashboard_body = jsonencode({
    widgets = []
  })
}
