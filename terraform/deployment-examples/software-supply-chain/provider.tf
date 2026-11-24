provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project    = "Zero-Trust-Reference-Architecture"
      Story      = "ZT-012"
      Capability = "Software-Supply-Chain-Security"
      ManagedBy  = "Terraform"
    }
  }
}
