###############################################################
# ZT-010 Enterprise Web Application Firewall
# Module Variables
###############################################################

variable "aws_region" {
  description = "AWS region where the WAF resources will be deployed."
  type        = string
}

variable "name" {
  description = "Name of the enterprise WAF Web ACL."
  type        = string
  default     = "enterprise-waf"
}

variable "scope" {
  description = "WAF scope. Use REGIONAL for regional resources or CLOUDFRONT for CloudFront."
  type        = string
  default     = "REGIONAL"

  validation {
    condition     = contains(["REGIONAL", "CLOUDFRONT"], var.scope)
    error_message = "scope must be either REGIONAL or CLOUDFRONT."
  }
}

variable "default_action" {
  description = "Default WAF action for requests that do not match a blocking rule."
  type        = string
  default     = "ALLOW"

  validation {
    condition     = contains(["ALLOW", "BLOCK"], var.default_action)
    error_message = "default_action must be either ALLOW or BLOCK."
  }
}

variable "enable_rate_limit" {
  description = "Enable a rate-based WAF rule."
  type        = bool
  default     = true
}

variable "rate_limit" {
  description = "Maximum requests allowed from a single IP within the WAF evaluation window."
  type        = number
  default     = 2000

  validation {
    condition     = var.rate_limit >= 100
    error_message = "rate_limit must be at least 100."
  }
}

variable "managed_rule_groups" {
  description = "AWS Managed Rule Groups to enable."
  type = list(object({
    name     = string
    vendor   = string
    priority = number
  }))

  default = [
    {
      name     = "AWSManagedRulesCommonRuleSet"
      vendor   = "AWS"
      priority = 10
    },
    {
      name     = "AWSManagedRulesKnownBadInputsRuleSet"
      vendor   = "AWS"
      priority = 20
    },
    {
      name     = "AWSManagedRulesSQLiRuleSet"
      vendor   = "AWS"
      priority = 30
    }
  ]
}

variable "blocked_ip_addresses" {
  description = "IPv4 CIDR addresses to block."
  type        = list(string)
  default     = []
}

variable "allowed_ip_addresses" {
  description = "IPv4 CIDR addresses to explicitly allow."
  type        = list(string)
  default     = []
}

variable "enable_logging" {
  description = "Enable WAF logging to CloudWatch Logs."
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "CloudWatch WAF log retention period."
  type        = number
  default     = 365
}

variable "tags" {
  description = "Enterprise tags applied to WAF resources."
  type        = map(string)
  default     = {}
}
