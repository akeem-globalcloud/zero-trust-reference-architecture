locals {

  common_tags = merge(
    {
      ManagedBy = "Terraform"
      Module    = "workload-protection"
    },
    var.workload.tags
  )

  instance_name = var.workload.name

  root_volume = merge(
    {
      size       = 50
      type       = "gp3"
      encrypted  = true
      kms_key_id = null
    },
    var.workload.root_volume
  )


}
