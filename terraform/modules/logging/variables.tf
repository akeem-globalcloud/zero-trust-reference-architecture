############################################
# AWS Configuration
############################################

variable "aws_region" {
  description = "AWS Region for deployment."
  type        = string
}

############################################
# Project Configuration
############################################

variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

############################################
# CloudTrail
############################################

variable "enable_cloudtrail" {
  description = "Enable AWS CloudTrail."
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  description = "Enable multi-region CloudTrail."
  type        = bool
  default     = true
}

############################################
# CloudWatch
############################################

variable "log_retention_days" {
  description = "CloudWatch Log retention."
  type        = number
  default     = 365
}

############################################
# AWS Config
############################################

variable "enable_config" {
  description = "Enable AWS Config."
  type        = bool
  default     = true
}

############################################
# Security Hub
############################################

variable "enable_securityhub" {
  description = "Enable AWS Security Hub."
  type        = bool
  default     = true
}

############################################
# SNS
############################################

variable "enable_sns_notifications" {
  description = "Enable SNS Alerts."
  type        = bool
  default     = true
}

############################################
# Tags
############################################

variable "tags" {
  description = "Additional tags."
  type        = map(string)
  default     = {}
}
