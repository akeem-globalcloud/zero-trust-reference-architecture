###############################################################
# Common Values
###############################################################

locals {

  key_description = coalesce(
    var.kms.description,
    "Enterprise KMS key for ${var.kms.name}"
  )

  alias_name = (
    startswith(var.kms.alias, "alias/")
      ? var.kms.alias
      : "alias/${var.kms.alias}"
  )

  default_tags = {
    ManagedBy = "Terraform"
    Module    = "kms-data-protection"
  }

  tags = merge(
    local.default_tags,
    var.kms.tags
  )

}
