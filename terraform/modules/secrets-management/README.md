# Enterprise Secrets Management Module

## Overview

The Enterprise Secrets Management module provisions AWS Secrets Manager resources using Terraform to securely store, encrypt, manage, and optionally rotate sensitive application secrets. The module is designed for enterprise environments following Zero Trust principles, Infrastructure as Code (IaC), and security best practices.

The module supports reusable deployments across development, test, staging, and production environments while enforcing standardized configuration and governance.

---

## Business Objective

Provide a centralized, secure, and reusable mechanism for managing application credentials, API keys, database passwords, certificates, and other confidential configuration values without exposing secrets in source code, Terraform state variables, or CI/CD pipelines.

---

## Features

- Secure secret storage using AWS Secrets Manager
- AWS KMS encryption support
- Customer-managed or AWS-managed KMS keys
- Configurable secret recovery window
- Optional automatic secret rotation
- Optional resource-based access policies
- Multi-region secret replication
- Standardized enterprise tagging
- Lifecycle protection
- Reusable Terraform module

---

## Module Structure

```text
terraform/modules/secrets-management/
├── locals.tf
├── main.tf
├── outputs.tf
├── policy.tf
├── README.md
├── variables.tf
└── versions.tf
```

---

## Resources Created

The module provisions the following resources as required:

- aws_secretsmanager_secret
- aws_secretsmanager_secret_version
- aws_secretsmanager_secret_rotation (optional)
- aws_secretsmanager_secret_policy (optional)

---

## Input Variable

The module accepts a single object named `secret`.

Example:

```hcl
secret = {

  name        = "prod/database"
  description = "Production database credentials"

  kms_key_id = "arn:aws:kms:..."

  recovery_window_in_days = 30

  secret = {
    username = "dbadmin"
    password = "ChangeMe123!"
  }

  rotation = {
    enabled                  = true
    lambda_arn               = "arn:aws:lambda:..."
    automatically_after_days = 30
  }

  tags = {
    Environment = "Production"
    Owner       = "Security"
  }

}
```

---

## Outputs

The module exports:

- secret_id
- secret_arn
- secret_name
- secret_version_id
- kms_key_id
- rotation_enabled
- secret_tags
- secret_recovery_window
- secret_rotation_lambda

---

## Security Controls

The module implements several enterprise security controls including:

- Encryption using AWS KMS
- Least-privilege resource policies
- Optional automatic rotation
- Recovery window before deletion
- Lifecycle protection
- Enterprise tagging standards
- Infrastructure as Code governance

---

## Validation

The module has been validated using:

```bash
terraform fmt
terraform validate
terraform plan
```

Security scanning was performed using:

```bash
checkov -d terraform/modules/secrets-management
```

---

## Checkov Exception

The module includes one documented security exception.

| Check ID | Reason |
|----------|--------|
| CKV_AWS_304 | The rotation interval is configurable for module consumers. Module validation enforces organizational policy, while static analysis cannot determine runtime values. |

---

## Compatibility

| Component | Version |
|----------|---------|
| Terraform | >= 1.13 |
| AWS Provider | ~> 6.0 |

---

## Related Documentation

- Story ZT-006 Enterprise Secrets Management
- ADR-006 Enterprise Secrets Management
- Deployment Guide
