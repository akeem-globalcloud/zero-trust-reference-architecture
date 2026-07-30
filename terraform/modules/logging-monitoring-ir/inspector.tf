#############################################################
# Amazon Inspector v2
# Story 4.1 (v0.4.1)
# Detection, Monitoring & Incident Response
#############################################################

###########################################
# Enable Amazon Inspector v2
###########################################

resource "aws_inspector2_enabler" "this" {
  account_ids = [data.aws_caller_identity.current.account_id]

  resource_types = [
    "EC2",
    "ECR",
    "LAMBDA"
  ]
}

###########################################
# Inspector Delegated Administrator
# (Optional for AWS Organizations)
###########################################

resource "aws_inspector2_delegated_admin_account" "this" {
  count = var.enable_delegated_admin ? 1 : 0

  account_id = var.delegated_admin_account_id
}

###########################################
# Inspector Organization Configuration
###########################################

resource "aws_inspector2_organization_configuration" "this" {
  count = var.enable_organization_configuration ? 1 : 0

  auto_enable {
    ec2             = true
    ecr             = true
    lambda          = true
    code_repository = false
  }

  depends_on = [
    aws_inspector2_delegated_admin_account.this
  ]
}

###########################################
# Inspector Resource Tags
###########################################

locals {
  inspector_tags = merge(
    var.tags,
    {
      Service   = "Amazon Inspector"
      ManagedBy = "Terraform"
      Story     = "4.1"
      Version   = "v0.4.1"
      Component = "Inspector"
    }
  )
}

###########################################
# Current AWS Account
###########################################

data "aws_caller_identity" "current" {}
