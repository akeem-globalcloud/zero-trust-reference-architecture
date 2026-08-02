module "kms_data_protection" {

  source = "../../modules/kms-data-protection"

  kms = var.kms
}
