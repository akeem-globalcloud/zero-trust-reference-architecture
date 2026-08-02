variable "secret" {

  description = "Enterprise Secrets Manager configuration."

  type = object({

    name        = string
    description = string

    kms_key_id = optional(string)

    recovery_window_in_days = optional(number, 30)

    secret = map(string)

    force_overwrite_replica_secret = optional(bool, false)

    tags = optional(map(string), {})

    rotation = optional(object({

      enabled                  = bool
      lambda_arn               = optional(string)
      automatically_after_days = optional(number, 30)

      }), {
      enabled = false
    })

    resource_policy = optional(object({

      enabled = bool

      principals = optional(list(string), [])

      actions = optional(list(string), [
        "secretsmanager:GetSecretValue"
      ])

      }), {
      enabled = false
    })

    replica_regions = optional(list(object({

      region     = string
      kms_key_id = optional(string)

    })), [])

  })

  validation {

    condition = (
      length(var.secret.name) > 0 &&
      length(var.secret.secret) > 0
    )

    error_message = "Secret name and secret values are required."

  }

}
