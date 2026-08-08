aws_region = "us-east-1"

siem = {

  name = "enterprise"

  securityhub = {

    enable_default_standards = true

  }

  eventbridge = {

    enabled = true

  }

  sns = {

    enabled       = true
    topic_name    = "enterprise-siem-findings"
    email_address = "security@example.com"

  }

  tags = {

    Environment = "Production"
    Owner       = "Cloud Security"
    Project     = "Zero Trust Reference Architecture"

  }

}