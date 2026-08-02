data "aws_region" "current" {}

####################################################
# Secrets Manager Secret
####################################################

resource "aws_secretsmanager_secret" "this" {

  name                    = var.secret.name
  description             = var.secret.description
  kms_key_id              = try(var.secret.kms_key_id, null)
  recovery_window_in_days = var.secret.recovery_window_in_days

  force_overwrite_replica_secret = var.secret.force_overwrite_replica_secret

  dynamic "replica" {

    for_each = var.secret.replica_regions

    content {
      region     = replica.value.region
      kms_key_id = try(replica.value.kms_key_id, null)
    }

  }

  tags = local.common_tags

  lifecycle {
    prevent_destroy = true
  }

}

####################################################
# Secret Version
####################################################

resource "aws_secretsmanager_secret_version" "this" {

  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(var.secret.secret)

}

####################################################
# Secret Rotation
####################################################

resource "aws_secretsmanager_secret_rotation" "this" {

  count = var.secret.rotation.enabled ? 1 : 0

  secret_id           = aws_secretsmanager_secret.this.id
  rotation_lambda_arn = try(var.secret.rotation.lambda_arn, null)

  rotation_rules {
    automatically_after_days = var.secret.rotation.automatically_after_days
  }

}
