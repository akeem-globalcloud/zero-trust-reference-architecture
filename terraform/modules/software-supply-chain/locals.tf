locals {
  resource_prefix = lower(var.name_prefix)

  common_tags = merge(
    {
      Project    = "Zero-Trust-Reference-Architecture"
      Story      = "ZT-012"
      Capability = "Software-Supply-Chain-Security"
      ManagedBy  = "Terraform"
    },
    var.tags
  )

  codebuild_project_name = "${local.resource_prefix}-supply-chain-build"
  codebuild_role_name    = "${local.resource_prefix}-codebuild-role"
  log_group_name         = "/aws/codebuild/${local.codebuild_project_name}"
}
