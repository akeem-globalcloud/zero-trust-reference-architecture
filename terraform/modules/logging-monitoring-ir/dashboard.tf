#############################################################
# Story 4.1 (v0.4.1)
# Detection, Monitoring & Incident Response
# Security Operations Dashboard
#############################################################

resource "aws_cloudwatch_dashboard" "security_operations" {
  dashboard_name = "${local.name_prefix}-security-operations"

  dashboard_body = jsonencode({

    widgets = [

      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 1

        properties = {
          markdown = "# ${local.name_prefix} Security Operations Dashboard"
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 1
        width  = 12
        height = 6

        properties = {
          title  = "Unauthorized API Calls"
          view   = "timeSeries"
          region = var.aws_region
          stat   = "Sum"

          metrics = [
            [
              "ZeroTrust/Security",
              "UnauthorizedApiCalls"
            ]
          ]
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 1
        width  = 12
        height = 6

        properties = {
          title  = "Console Login Failures"
          region = var.aws_region
          stat   = "Sum"

          metrics = [
            [
              "ZeroTrust/Security",
              "ConsoleLoginFailure"
            ]
          ]
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 7
        width  = 12
        height = 6

        properties = {
          title  = "Root Account Usage"
          region = var.aws_region

          metrics = [
            [
              "ZeroTrust/Security",
              "RootAccountUsage"
            ]
          ]
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 7
        width  = 12
        height = 6

        properties = {
          title  = "IAM Policy Changes"
          region = var.aws_region

          metrics = [
            [
              "ZeroTrust/Security",
              "IAMPolicyChanges"
            ]
          ]
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 13
        width  = 12
        height = 6

        properties = {
          title  = "Security Group Changes"
          region = var.aws_region

          metrics = [
            [
              "ZeroTrust/Security",
              "SecurityGroupChanges"
            ]
          ]
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 13
        width  = 12
        height = 6

        properties = {
          title  = "CloudTrail Changes"
          region = var.aws_region

          metrics = [
            [
              "ZeroTrust/Security",
              "CloudTrailConfigurationChanges"
            ]
          ]
        }
      }

    ]

  })
}
