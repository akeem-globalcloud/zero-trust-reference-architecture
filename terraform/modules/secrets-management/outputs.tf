output "secret_id" {
  description = "Secrets Manager Secret ID."
  value       = aws_secretsmanager_secret.this.id
}

output "secret_arn" {
  description = "Secrets Manager Secret ARN."
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_name" {
  description = "Secrets Manager Secret Name."
  value       = aws_secretsmanager_secret.this.name
}

output "secret_version_id" {
  description = "Current secret version ID."
  value       = aws_secretsmanager_secret_version.this.version_id
}

output "kms_key_id" {
  description = "KMS Key ID used to encrypt the secret."
  value       = aws_secretsmanager_secret.this.kms_key_id
}

output "rotation_enabled" {
  description = "Whether automatic rotation is enabled."
  value       = var.secret.rotation.enabled
}
