output "codeartifact_domain_name" {
  description = "CodeArtifact domain name."
  value       = aws_codeartifact_domain.this.domain
}

output "codeartifact_domain_arn" {
  description = "CodeArtifact domain ARN."
  value       = aws_codeartifact_domain.this.arn
}

output "codeartifact_repository_name" {
  description = "Private CodeArtifact repository name."
  value       = aws_codeartifact_repository.this.repository
}

output "codeartifact_repository_arn" {
  description = "Private CodeArtifact repository ARN."
  value       = aws_codeartifact_repository.this.arn
}

output "codebuild_project_name" {
  description = "CodeBuild project name."
  value       = try(aws_codebuild_project.this[0].name, null)
}

output "codebuild_project_arn" {
  description = "CodeBuild project ARN."
  value       = try(aws_codebuild_project.this[0].arn, null)
}

output "codebuild_role_arn" {
  description = "CodeBuild service role ARN."
  value       = try(aws_iam_role.codebuild[0].arn, null)
}

output "ecr_repository_name" {
  description = "ECR repository name."
  value       = aws_ecr_repository.artifacts.name
}

output "ecr_repository_url" {
  description = "ECR repository URL."
  value       = aws_ecr_repository.artifacts.repository_url
}

output "ecr_repository_arn" {
  description = "ECR repository ARN."
  value       = aws_ecr_repository.artifacts.arn
}

output "signing_profile_name" {
  description = "AWS Signer profile name, when enabled."
  value       = try(aws_signer_signing_profile.oci[0].name, null)
}

output "signing_profile_arn" {
  description = "AWS Signer profile ARN, when enabled."
  value       = try(aws_signer_signing_profile.oci[0].arn, null)
}

output "cloudwatch_log_group_name" {
  description = "CodeBuild CloudWatch log group."
  value       = aws_cloudwatch_log_group.codebuild.name
}

output "codeartifact_kms_key_arn" {
  description = "Customer-managed KMS key ARN for CodeArtifact."
  value       = aws_kms_key.codeartifact.arn
}

output "cloudwatch_kms_key_arn" {
  description = "Customer-managed KMS key ARN for CloudWatch Logs."
  value       = aws_kms_key.cloudwatch.arn
}

output "ecr_kms_key_arn" {
  description = "Customer-managed KMS key ARN for ECR."
  value       = aws_kms_key.ecr.arn
}
