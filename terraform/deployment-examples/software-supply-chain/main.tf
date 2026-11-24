module "software_supply_chain" {
  source = "../../modules/software-supply-chain"

  name_prefix = "zt012"

  github_repository_url = var.github_repository_url
  github_source_version = var.github_source_version

  codeartifact_domain_name     = "zt012-packages"
  codeartifact_repository_name = "enterprise-packages"

  ecr_repository_name      = "zt012-enterprise-artifacts"
  ecr_image_tag_mutability = "IMMUTABLE"
  ecr_scan_on_push         = true

  enable_codebuild          = var.enable_codebuild
  codebuild_privileged_mode = var.codebuild_privileged_mode
  enable_signing_profile    = var.enable_signing_profile

  log_retention_days = 365

  tags = {
    Environment = var.environment
  }
}
