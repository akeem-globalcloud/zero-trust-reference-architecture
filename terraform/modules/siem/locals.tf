###############################################################
# Local Values
###############################################################

locals {

  common_tags = merge(

    {
      ManagedBy   = "Terraform"
      Project     = "Zero Trust Reference Architecture"
      Module      = "Enterprise SIEM"
      Provisioner = "Terraform"
    },

    try(var.siem.tags, {})

  )

}
