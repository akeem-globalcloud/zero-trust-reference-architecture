###############################################################
# ZT-010 Enterprise Web Application Firewall
# Deployment Variables
###############################################################

variable "aws_region" {
  description = "AWS deployment region."
  type        = string
}

variable "name" {
  description = "Enterprise WAF Web ACL name."
  type        = string
}

variable "scope" {
  description = "WAF scope: REGIONAL or CLOUDFRONT."
  type        = string

  validation {
    condition     = contains(["REGIONAL", "CLOUDFRONT"], var.scope)
    error_message = "scope must be either REGIONAL or CLOUDFRONT."
  }
}

variable "default_action" {
  description = "Default WAF action."
  type        = string

  validation {
    condition     = contains(["ALLOW", "BLOCK"], var.default_action)
    error_message = "default_action must be either ALLOW or BLOCK."
  }
}

variable "enable_rate_limit" {
  description = "Enable WAF rate limiting."
  type        = bool
}

variable "rate_limit" {
  description = "Requests per IP before rate-based blocking."
  type        = number
}

variable "managed_rule_groups" {
  description = "AWS Managed Rule Groups."
  type = list(object({
    name     = string
    vendor   = string
    priority = number
  }))
}

variable "blocked_ip_addresses" {
  description = "IPv4 CIDR addresses to block."
  type        = list(string)
}

variable "allowed_ip_addresses" {
  description = "IPv4 CIDR addresses to allow."
  type        = list(string)
}

variable "enable_logging" {
  description = "Enable WAF logging."
  type        = bool
}

variable "log_retention_days" {
  description = "WAF log retention period."
  type        = number
}

variable "tags" {
  description = "Enterprise resource tags."
  type        = map(string)
}
