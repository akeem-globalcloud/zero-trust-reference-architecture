###############################################################
# ZT-010 Enterprise Web Application Firewall
# AWS Provider
###############################################################

terraform {
  required_version = ">= 1.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project    = "Zero Trust Reference Architecture"
      Story      = "ZT-010"
      Capability = "Enterprise Web Application Firewall"
      ManagedBy  = "Terraform"
    }
  }
}
