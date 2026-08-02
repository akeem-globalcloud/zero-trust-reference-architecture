variable "workload" {

  description = "Enterprise workload protection configuration."

  type = object({

    name          = string
    ami_id        = string
    instance_type = string

    subnet_id = string
    vpc_id    = string

    private_ip          = optional(string)
    availability_zone   = optional(string)
    associate_public_ip = optional(bool, false)

    iam = optional(object({
      create_ssm_role = optional(bool, true)
    }), {})

    root_volume = optional(object({

      size       = optional(number, 50)
      type       = optional(string, "gp3")
      encrypted  = optional(bool, true)
      kms_key_id = optional(string)

    }), {})

    metadata = optional(object({

      http_endpoint               = optional(string, "enabled")
      http_tokens                 = optional(string, "required")
      http_put_response_hop_limit = optional(number, 2)
      instance_metadata_tags      = optional(string, "enabled")

    }), {})

    monitoring = optional(object({

      detailed_monitoring = optional(bool, true)

    }), {})

    inspector = optional(object({

      enabled = optional(bool, true)

    }), {})

    security_group = optional(object({

      ingress = optional(list(any), [])
      egress  = optional(list(any), [])

    }), {})

    tags = optional(map(string), {})

  })

  validation {

    condition = (
      length(var.workload.name) > 0 &&
      length(var.workload.ami_id) > 0
    )

    error_message = "Instance name and AMI ID are required."

  }

}
