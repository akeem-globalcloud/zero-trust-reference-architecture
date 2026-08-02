#############################################################
# Story 4.1 (v0.4.1)
# Detection, Monitoring & Incident Response
# Organization CloudTrail
#############################################################

#############################################
# Organization Trail
#############################################

resource "aws_cloudtrail" "organization" {
  count = var.enable_organization_trail ? 1 : 0

  name                          = "${local.name_prefix}-organization-trail"
  s3_bucket_name                = var.cloudtrail_bucket_name
  is_organization_trail         = true
  is_multi_region_trail         = true
  include_global_service_events = true

  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_logs.arn

  enable_log_file_validation = var.enable_log_file_validation

  depends_on = [
    aws_cloudwatch_log_group.cloudtrail
  ]

  tags = merge(
    var.tags,
    {
      Name      = "${local.name_prefix}-organization-trail"
      Component = "CloudTrail"
      Story     = "4.1"
      Scope     = "Organization"
    }
  )
}
