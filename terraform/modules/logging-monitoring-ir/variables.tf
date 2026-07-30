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

#############################################################
# Variables
# Story 4.1 (v0.4.1)
# Detection, Monitoring & Incident Response
#############################################################

variable "enable_delegated_admin" {
  description = "Enable Inspector delegated administrator."
  type        = bool
  default     = false
}

variable "delegated_admin_account_id" {
  description = "AWS Account ID designated as Inspector delegated administrator."
  type        = string
  default     = ""
}

variable "enable_organization_configuration" {
  description = "Enable Inspector organization-wide auto enrollment."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to resources."
  type        = map(string)
  default     = {}
}

#############################################################
# Organization CloudTrail
#############################################################

variable "enable_organization_trail" {
  description = "Deploy an AWS Organizations CloudTrail."
  type        = bool
  default     = false
}

variable "cloudtrail_bucket_name" {
  description = "S3 bucket used for CloudTrail logs."
  type        = string
}

#############################################################
# CloudTrail Log File Validation
#############################################################

variable "enable_log_file_validation" {
  description = "Enable CloudTrail log file integrity validation."
  type        = bool
  default     = true
}
