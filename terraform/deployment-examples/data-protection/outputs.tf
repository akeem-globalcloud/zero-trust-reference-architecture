###############################################################
# KMS Outputs
###############################################################

output "kms_key_id" {
  value = module.kms_data_protection.key_id
}

output "kms_key_arn" {
  value = module.kms_data_protection.key_arn
}

output "kms_alias" {
  value = module.kms_data_protection.key_alias
}

output "kms_policy" {
  value = module.kms_data_protection.key_policy
}

output "rotation_enabled" {
  value = module.kms_data_protection.rotation_enabled
}

output "multi_region" {
  value = module.kms_data_protection.multi_region
}
