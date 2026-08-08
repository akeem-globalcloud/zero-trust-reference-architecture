###############################################################
# AWS Region
###############################################################

variable "aws_region" {

  description = "AWS Region where SIEM resources will be deployed."

  type = string

  default = "us-east-1"
}

###############################################################
# Enterprise SIEM Configuration
###############################################################

variable "siem" {

  description = "Enterprise SIEM configuration."

  type = object({

    name = string

    securityhub = optional(object({

      enable_default_standards = optional(bool, true)

    }), {})

    eventbridge = optional(object({

      enabled = optional(bool, true)

    }), {})

    sns = optional(object({

      enabled       = bool
      topic_name    = string
      email_address = string

    }))

    tags = optional(map(string), {})

  })

  validation {

    condition = length(trimspace(var.siem.name)) > 0

    error_message = "SIEM name cannot be empty."

  }

}
