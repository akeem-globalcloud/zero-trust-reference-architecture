variable "aws_region" {
  description = "AWS Region for the software supply chain resources."
  type        = string
  default     = "us-east-1"
}

variable "github_repository_url" {
  description = "HTTPS URL of the GitHub repository used by CodeBuild."
  type        = string
}

variable "github_source_version" {
  description = "Git branch, tag, or commit used by CodeBuild."
  type        = string
  default     = "main"
}

variable "environment" {
  description = "Deployment environment label."
  type        = string
  default     = "development"
}

variable "enable_codebuild" {
  description = "Whether to create the CodeBuild project."
  type        = bool
  default     = true
}

variable "codebuild_privileged_mode" {
  description = "Enable privileged mode when Docker builds are required."
  type        = bool
  default     = false
}

variable "enable_signing_profile" {
  description = "Whether to create the AWS Signer OCI profile."
  type        = bool
  default     = true
}
