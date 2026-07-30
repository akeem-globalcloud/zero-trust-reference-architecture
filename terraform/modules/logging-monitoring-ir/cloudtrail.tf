resource "aws_s3_bucket" "cloudtrail" {
  bucket = "${local.name_prefix}-cloudtrail-logs"

  tags = merge(
    local.common_tags,
    {
      Name      = "${local.name_prefix}-cloudtrail-logs"
      Component = "S3"
    }
  )
}

resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "/aws/cloudtrail/${local.name_prefix}"
  retention_in_days = var.log_retention_days

  tags = merge(
    local.common_tags,
    {
      Name      = "/aws/cloudtrail/${local.name_prefix}"
      Component = "CloudWatchLogs"
    }
  )
}

resource "aws_cloudtrail" "this" {

  count = var.enable_cloudtrail ? 1 : 0

  name                          = "${local.name_prefix}-trail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail.id
  include_global_service_events = true
  is_multi_region_trail         = var.is_multi_region_trail
  enable_logging                = true

  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_logs.arn

  tags = merge(
    local.common_tags,
    {
      Name      = "${local.name_prefix}-trail"
      Component = "CloudTrail"
    }
  )
}
