###############################################################
# Outputs
###############################################################

output "key_id" {

  description = "KMS Key ID."

  value = aws_kms_key.this.key_id

}

output "key_arn" {

  description = "KMS Key ARN."

  value = aws_kms_key.this.arn

}

output "key_alias" {

  description = "KMS Alias."

  value = aws_kms_alias.this.name

}

output "key_policy" {

  description = "Generated KMS key policy."

  value = data.aws_iam_policy_document.merged.json

}

output "rotation_enabled" {

  description = "Whether automatic key rotation is enabled."

  value = aws_kms_key.this.enable_key_rotation

}

output "multi_region" {

  description = "Whether the key is multi-region."

  value = aws_kms_key.this.multi_region

}
