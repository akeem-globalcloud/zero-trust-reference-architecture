module "secrets_management" {

  source = "../../modules/secrets-management"

  secret = var.secret

}
