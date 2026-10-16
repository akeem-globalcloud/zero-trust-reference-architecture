###############################################################
# Terraform and AWS Provider Requirements
# ZT-010 Enterprise Web Application Firewall
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
