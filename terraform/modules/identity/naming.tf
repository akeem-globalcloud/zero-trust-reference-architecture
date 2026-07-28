locals {

  role_name = lower(
    "${local.resource_prefix}-${var.role_name}"
  )

  policy_name = lower(
    "${local.resource_prefix}-${var.role_name}-policy"
  )

}
