variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition = contains(
      ["dev", "test", "stage", "prod"],
      var.environment
    )

    error_message = "Environment must be one of: dev, test, stage, prod."
  }
}

variable "role_name" {
  description = "Logical IAM role name."
  type        = string
}

variable "role_description" {
  description = "Description of the IAM role."
  type        = string
  default     = ""
}

variable "trusted_services" {
  description = "AWS services allowed to assume the role."
  type        = list(string)

  default = [
    "ec2.amazonaws.com"
  ]
}

variable "managed_policy_arns" {
  description = "Managed policy ARNs to attach."
  type        = list(string)
  default     = []
}

variable "permission_boundary_arn" {
  description = "Optional IAM permission boundary."
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional resource tags."
  type        = map(string)
  default     = {}
}
