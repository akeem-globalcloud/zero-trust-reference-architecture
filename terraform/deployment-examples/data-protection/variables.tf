###############################################################
# AWS Provider
###############################################################

variable "aws_region" {
  description = "AWS Region to deploy resources."
  type        = string
}

###############################################################
# Provider Default Tags
###############################################################

variable "default_tags" {
  description = "Default provider tags."
  type        = map(string)

  default = {}
}

###############################################################
# KMS Configuration
###############################################################

variable "kms" {
  description = "KMS configuration."
  type        = any
}
