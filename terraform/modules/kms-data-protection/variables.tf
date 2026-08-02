###############################################################
# KMS Configuration
###############################################################

variable "kms" {

  description = "Configuration object for the KMS key."

  type = object({

    #########################################################
    # General
    #########################################################

    name        = string
    alias       = string
    description = optional(string)

    #########################################################
    # Cryptography
    #########################################################

    key_spec  = optional(string, "SYMMETRIC_DEFAULT")
    key_usage = optional(string, "ENCRYPT_DECRYPT")

    #########################################################
    # Security
    #########################################################

    rotation_enabled        = optional(bool, true)
    multi_region            = optional(bool, false)
    deletion_window_in_days = optional(number, 30)

    #########################################################
    # Access
    #########################################################

    access = optional(object({
      administrators     = optional(set(string), [])
      users              = optional(set(string), [])
      service_principals = optional(set(string), [])
    }), {})

    #########################################################
    # Policy Extensions
    #########################################################

    additional_policy_documents = optional(list(string), [])

    #########################################################
    # Tags
    #########################################################

    tags = optional(map(string), {})

  })

  validation {
    condition = contains([
      "SYMMETRIC_DEFAULT",
      "RSA_2048",
      "RSA_3072",
      "RSA_4096",
      "ECC_NIST_P256",
      "ECC_NIST_P384",
      "ECC_NIST_P521",
      "ECC_SECG_P256K1",
      "HMAC_256",
      "HMAC_384",
      "HMAC_512"
    ], var.kms.key_spec)

    error_message = "Unsupported KMS key specification."
  }

  validation {
    condition = contains([
      "ENCRYPT_DECRYPT",
      "SIGN_VERIFY",
      "GENERATE_VERIFY_MAC"
    ], var.kms.key_usage)

    error_message = "Unsupported KMS key usage."
  }

  validation {
    condition = (
      var.kms.deletion_window_in_days >= 7 &&
      var.kms.deletion_window_in_days <= 30
    )

    error_message = "Deletion window must be between 7 and 30 days."
  }

}
