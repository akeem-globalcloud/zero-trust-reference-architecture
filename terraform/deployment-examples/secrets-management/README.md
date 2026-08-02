# Enterprise Secrets Management Deployment

## Story

**ZT-006 – Enterprise Secrets Management**

---

## Objective

**As a Cloud Security Engineer, deploy AWS Secrets Manager using Terraform so that application secrets, API keys, database credentials, certificates, and other sensitive configuration values are securely stored, encrypted, rotated, and accessed using least-privilege permissions while supporting Zero Trust security principles and enterprise compliance requirements.**

---

# Overview

This deployment provisions AWS Secrets Manager resources using the reusable Enterprise Secrets Management Terraform module. The deployment demonstrates how organizations can securely manage application secrets while integrating encryption, optional rotation, replication, and resource-based access controls.

The deployment is intended for enterprise environments implementing Zero Trust Architecture and Infrastructure as Code (IaC).

---

# Architecture

```
                    Enterprise Applications
                             │
                             ▼
                  AWS Secrets Manager Secret
                             │
              ┌──────────────┴──────────────┐
              │                             │
              ▼                             ▼
     Customer Managed KMS           AWS Managed KMS
              │
              ▼
      Encrypted Secret Storage
              │
              ▼
      IAM Roles / Applications
```

---

# Deployment Structure

```text
terraform/deployment-examples/secrets-management/
├── main.tf
├── outputs.tf
├── provider.tf
├── README.md
├── terraform.tfvars.example
└── variables.tf
```

---

# Prerequisites

Before deployment, ensure the following are available:

- AWS account
- Terraform 1.13 or later
- AWS CLI configured
- IAM permissions to manage:
  - AWS Secrets Manager
  - AWS KMS
  - IAM resource policies

---

# Configuration

Update the deployment variables in `terraform.tfvars`.

Example:

```hcl
aws_region = "us-east-1"

secret = {

  name        = "production/database"

  description = "Production database credentials"

  kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/xxxxxxxx"

  recovery_window_in_days = 30

  secret = {
    username = "dbadmin"
    password = "ChangeMe123!"
  }

  rotation = {
    enabled                  = true
    lambda_arn               = "arn:aws:lambda:us-east-1:123456789012:function:rotate-secret"
    automatically_after_days = 30
  }

  tags = {
    Environment = "Production"
    Owner       = "Cloud Security"
    Project     = "Zero Trust"
  }

}
```

---

# Deployment Steps

Initialize Terraform.

```bash
terraform init
```

Review the execution plan.

```bash
terraform plan
```

Deploy the infrastructure.

```bash
terraform apply
```

Verify the deployed resources.

```bash
terraform output
```

---

# Resources Deployed

Depending on configuration, the deployment creates:

- AWS Secrets Manager Secret
- Secret Version
- Secret Rotation Configuration (optional)
- Secret Resource Policy (optional)

---

# Validation

Validate the Terraform configuration.

```bash
terraform fmt -recursive
terraform validate
terraform plan
```

Run a security scan.

```bash
checkov -d terraform/deployment-examples/secrets-management
```

---

# Security Controls

This deployment implements the following enterprise security controls:

- AWS KMS encryption
- Least-privilege access
- Optional automatic rotation
- Configurable recovery window
- Resource-based access control
- Infrastructure as Code governance
- Enterprise resource tagging
- Audit support through AWS CloudTrail

---

# Known Exception

| Check ID | Status | Justification |
|----------|--------|---------------|
| CKV_AWS_304 | Approved Exception | Secret rotation interval is configurable for reusable module consumers. Module validation enforces organizational policy, while static analysis cannot evaluate runtime input values. |

---

# Expected Outputs

Successful deployment returns:

- Secret ID
- Secret ARN
- Secret Name
- Secret Version ID
- KMS Key ID
- Rotation Status

---

# Rollback

To remove the deployment:

```bash
terraform destroy
```

AWS Secrets Manager recovery settings may delay permanent deletion according to the configured recovery window.

---

# Related Documentation

- Story ZT-006 – Enterprise Secrets Management
- ADR-006 – Enterprise Secrets Management
- Module Documentation
