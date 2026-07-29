variable "aws_region" {
  description = "AWS deployment region."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name."
  type        = string
  default     = "zero-trust"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}
