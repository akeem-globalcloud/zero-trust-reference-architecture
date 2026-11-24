resource "aws_signer_signing_profile" "oci" {
  count = var.enable_signing_profile ? 1 : 0

  name        = var.signing_profile_name
  platform_id = "Notation-OCI-SHA384-ECDSA"

  signature_validity_period {
    value = 2
    type  = "YEARS"
  }

  tags = local.common_tags
}
