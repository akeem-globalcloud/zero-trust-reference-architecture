variable "name_prefix" {
  description = "Prefix used to name software supply chain resources."
  type        = string
  default     = "zt012"
}

variable "tags" {
  description = "Tags applied to supported resources."
  type        = map(string)
  default     = {}
}

variable "codeartifact_domain_name" {
  description = "Name of the private CodeArtifact domain."
  type        = string
  default     = "zt012-packages"
}

variable "codeartifact_repository_name" {
  description = "Name of the private CodeArtifact repository."
  type        = string
  default     = "enterprise-packages"
}

variable "codeartifact_external_connections" {
  description = "Optional external connections for upstream package repositories."
  type        = list(string)
  default     = []
}

variable "github_repository_url" {
  description = "GitHub repository URL used as the CodeBuild source."
  type        = string
}

variable "github_source_version" {
  description = "Git branch, tag, or commit used by CodeBuild."
  type        = string
  default     = "main"
}

variable "codebuild_environment_image" {
  description = "CodeBuild managed image."
  type        = string
  default     = "aws/codebuild/standard:7.0"
}

variable "codebuild_compute_type" {
  description = "Compute capacity for the CodeBuild environment."
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}

variable "codebuild_timeout" {
  description = "Maximum build duration in minutes."
  type        = number
  default     = 60
}

variable "codebuild_privileged_mode" {
  description = "Enable privileged mode when Docker image builds are required."
  type        = bool
  default     = false
}

variable "buildspec" {
  description = "Inline CodeBuild build specification."
  type        = string
  default     = <<-BUILDSPEC
    version: 0.2
    phases:
      install:
        commands:
          - echo "Software supply chain security build"
      pre_build:
        commands:
          - echo "Preparing build environment"
      build:
        commands:
          - echo "Run dependency, source, and artifact security checks here"
      post_build:
        commands:
          - echo "Build workflow completed"
  BUILDSPEC
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository for container artifacts."
  type        = string
  default     = "zt012-enterprise-artifacts"
}

variable "ecr_image_tag_mutability" {
  description = "Image tag mutability setting."
  type        = string
  default     = "IMMUTABLE"

  validation {
    condition     = contains(["IMMUTABLE", "MUTABLE"], var.ecr_image_tag_mutability)
    error_message = "Image tag mutability must be IMMUTABLE or MUTABLE."
  }
}

variable "ecr_scan_on_push" {
  description = "Enable ECR basic image scanning on image push."
  type        = bool
  default     = true
}

variable "ecr_force_delete" {
  description = "Allow ECR repository deletion when it contains images."
  type        = bool
  default     = false
}

variable "enable_signing_profile" {
  description = "Create an AWS Signer profile for OCI container image signing."
  type        = bool
  default     = true
}

variable "signing_profile_name" {
  description = "Name of the AWS Signer signing profile."
  type        = string
  default     = "zt012ocisigning"
}

variable "log_retention_days" {
  description = "CloudWatch log retention period in days."
  type        = number
  default     = 365
}

variable "enable_codebuild" {
  description = "Whether to create the CodeBuild project."
  type        = bool
  default     = true
}

variable "kms_deletion_window_days" {
  description = "Waiting period before a scheduled KMS key deletion."
  type        = number
  default     = 30

  validation {
    condition = (
      var.kms_deletion_window_days >= 7 &&
      var.kms_deletion_window_days <= 30
    )
    error_message = "KMS deletion window must be between 7 and 30 days."
  }
}
