###############################################################
# AWS Security Hub
###############################################################

resource "aws_securityhub_account" "this" {

  enable_default_standards = var.siem.securityhub.enable_default_standards

}

###############################################################
# AWS Foundational Security Best Practices
###############################################################

resource "aws_securityhub_standards_subscription" "aws_foundational" {

  depends_on = [
    aws_securityhub_account.this
  ]

  standards_arn = "arn:aws:securityhub:${data.aws_region.current.region}::standards/aws-foundational-security-best-practices/v/1.0.0"

}

###############################################################
# CIS AWS Foundations Benchmark
###############################################################

resource "aws_securityhub_standards_subscription" "cis" {

  depends_on = [
    aws_securityhub_account.this
  ]

  standards_arn = "arn:aws:securityhub:${data.aws_region.current.region}::standards/cis-aws-foundations-benchmark/v/1.2.0"

}
