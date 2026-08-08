###############################################################
# Enterprise SIEM
###############################################################

module "siem" {

  source = "../../modules/siem"

  aws_region = var.aws_region

  siem = var.siem

}
