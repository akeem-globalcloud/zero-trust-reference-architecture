output "secret_id" {

  value = module.secrets_management.secret_id

}

output "secret_arn" {

  value = module.secrets_management.secret_arn

}

output "secret_name" {

  value = module.secrets_management.secret_name

}

output "secret_version_id" {

  value = module.secrets_management.secret_version_id

}

output "kms_key_id" {

  value = module.secrets_management.kms_key_id

}

output "rotation_enabled" {

  value = module.secrets_management.rotation_enabled

}
