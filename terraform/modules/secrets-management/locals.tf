locals {

  common_tags = merge(

    {
      ManagedBy = "Terraform"
      Module    = "secrets-management"
    },

    var.secret.tags

  )

}
