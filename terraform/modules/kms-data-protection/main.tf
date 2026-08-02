###############################################################
# KMS Key
###############################################################

resource "aws_kms_key" "this" {

  description              = local.key_description
  key_usage                = var.kms.key_usage
  customer_master_key_spec = var.kms.key_spec

  enable_key_rotation = (
    var.kms.key_spec == "SYMMETRIC_DEFAULT"
      ? var.kms.rotation_enabled
      : false
  )

  multi_region            = var.kms.multi_region
  deletion_window_in_days = var.kms.deletion_window_in_days

  policy = data.aws_iam_policy_document.merged.json

  tags = local.tags

  lifecycle {
    prevent_destroy = true
  }
}
