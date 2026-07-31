resource "aws_s3_bucket" "cloudtrail" {

  bucket = "${local.name_prefix}-cloudtrail-logs"

  force_destroy = false

  tags = merge(
    local.common_tags,
    {
      Name      = "${local.name_prefix}-cloudtrail-logs"
      Component = "S3"
    }
  )
}

resource "aws_s3_bucket_versioning" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.logging.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "/aws/cloudtrail/${local.name_prefix}"
  retention_in_days = var.log_retention_days
  kms_key_id        = aws_kms_key.logging.arn

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

  enable_log_file_validation = var.enable_log_file_validation
  kms_key_id                 = aws_kms_key.logging.arn

  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_logs.arn

  sns_topic_name = var.enable_sns_notifications ? aws_sns_topic.security[0].name : null

  tags = merge(
    local.common_tags,
    {
      Name      = "${local.name_prefix}-trail"
      Component = "CloudTrail"
    }
  )
}

resource "aws_s3_bucket_logging" "cloudtrail" {

  bucket = aws_s3_bucket.cloudtrail.id

  target_bucket = aws_s3_bucket.cloudtrail.id

  target_prefix = "access-logs/"
}

resource "aws_s3_bucket_lifecycle_configuration" "cloudtrail" {

  bucket = aws_s3_bucket.cloudtrail.id

  rule {

    id = "cloudtrail-log-lifecycle"

    status = "Enabled"

    filter {
      prefix = ""
    }

    transition {

      days = 90

      storage_class = "STANDARD_IA"
    }

    expiration {

      days = 3650
    }
  }
}
