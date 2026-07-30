resource "aws_securityhub_account" "this" {

  count = var.enable_securityhub ? 1 : 0

  enable_default_standards = true
}
