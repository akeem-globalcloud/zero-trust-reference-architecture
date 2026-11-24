output "codeartifact_domain_name" {
  description = "CodeArtifact domain."
  value       = module.software_supply_chain.codeartifact_domain_name
}

output "codeartifact_repository_name" {
  description = "Private package repository."
  value       = module.software_supply_chain.codeartifact_repository_name
}

output "codebuild_project_name" {
  description = "CodeBuild project name."
  value       = module.software_supply_chain.codebuild_project_name
}

output "codebuild_project_arn" {
  description = "CodeBuild project ARN."
  value       = module.software_supply_chain.codebuild_project_arn
}

output "ecr_repository_url" {
  description = "ECR repository URL."
  value       = module.software_supply_chain.ecr_repository_url
}

output "signing_profile_arn" {
  description = "AWS Signer profile ARN."
  value       = module.software_supply_chain.signing_profile_arn
}

output "cloudwatch_log_group_name" {
  description = "CodeBuild CloudWatch log group."
  value       = module.software_supply_chain.cloudwatch_log_group_name
}
