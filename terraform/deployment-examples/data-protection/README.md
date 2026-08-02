#  Data Protection & Cryptography


## Overview

This deployment demonstrates how to provision enterprise-grade cryptographic infrastructure using the reusable **kms-data-protection** Terraform module.

The deployment creates an AWS Key Management Service (AWS KMS) Customer Managed Key (CMK) that provides centralized encryption services for workloads within the Zero Trust Reference Architecture. The module implements security best practices including least-privilege access, automatic key rotation, lifecycle protection, enterprise tagging, and configurable AWS service integration.

This  serves as the reference deployment for **Story ZT-005 – Enterprise Data Protection & Cryptography**.

---

## Story Information

| Property | Value |
|----------|-------|
| Story ID | ZT-005 |
| Story | Enterprise Data Protection & Cryptography |
| Epic | Enterprise Security Foundation |
| Priority | High |
| Module | kms-data-protection |

---

## Story Description

**As a Cloud Security Engineer**, deploy AWS Key Management Service (AWS KMS) using Terraform so that enterprise workloads can securely encrypt sensitive data using centrally managed customer-managed keys while enforcing Zero Trust security principles, least-privilege access, automated key rotation, and standardized governance across AWS environments.

---

## Business Objective

Enterprise applications require centralized encryption services to protect sensitive information such as:

- Customer records
- Healthcare data
- Financial transactions
- Authentication secrets
- Application configuration
- Infrastructure metadata

This deployment establishes a reusable encryption platform that can be consumed by AWS services including Amazon S3, Amazon EBS, Amazon RDS, AWS Secrets Manager, Lambda, and other workloads requiring customer-managed encryption keys.

---

## Architecture

```
                Enterprise Applications
                         │
                         ▼
                   AWS Service
                         │
                         ▼
                    KMS Alias
                         │
                         ▼
               Customer Managed Key
                         │
      ┌──────────────────┴──────────────────┐
      │                                     │
 IAM Administrators               AWS Service Principals
      │                                     │
      ▼                                     ▼
 Enterprise IAM                     Amazon S3
                                   Amazon EBS
                                   Amazon RDS
                                   Secrets Manager
```

---

## Resources Deployed

This deployment provisions the following AWS resources:

| Resource | Description |
|----------|-------------|
| AWS KMS Customer Managed Key | Enterprise encryption key |
| AWS KMS Alias | Friendly alias for workloads |
| IAM Key Policy | Least-privilege access policy |

---

## Directory Structure

```text
terraform/
├── deployment-examples/
│   └── data-protection/
│       ├── main.tf
│       ├── outputs.tf
│       ├── provider.tf
│       ├── terraform.tfvars.example
│       ├── variables.tf
│       └── versions.tf
│
└── modules/
    └── kms-data-protection/
        ├── aliases.tf
        ├── data.tf
        ├── key-policy.tf
        ├── main.tf
        ├── outputs.tf
        ├── variables.tf
        └── versions.tf 
```

---

## Prerequisites

Before deploying this example, ensure the following requirements are met:

- Terraform v1.13 or later
- AWS CLI installed and configured
- Valid AWS credentials
- AWS Provider v6.x
- IAM permissions to create AWS KMS resources

Verify your AWS identity:

```bash
aws sts get-caller-identity
```

---

## Deployment

Initialize Terraform:

```bash
terraform init
```

Validate the configuration:

```bash
terraform validate
```

Review the deployment plan:

```bash
terraform plan
```

Deploy the infrastructure:

```bash
terraform apply
```

---

## Configuration

Copy the sample configuration:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Modify the values according to your environment.

Example:

```hcl
aws_region = "us-east-1"

kms = {
  name        = "enterprise-kms-key"
  alias       = "enterprise-kms-key"

  rotation_enabled = true

  multi_region = false

  access = {
    administrators     = []
    users              = []
    service_principals = [
      "s3.amazonaws.com"
    ]
  }

  tags = {
    Environment = "dev"
    Project     = "ZeroTrust"
  }
}
```

---

## Deployment Validation

After deployment, verify that:

- The KMS key has been created.
- The alias is attached to the key.
- Automatic key rotation is enabled.
- The generated IAM policy matches organizational requirements.
- AWS service principals have only the required permissions.
- Terraform completes successfully without errors.

---

## Outputs

The deployment exposes the following outputs:

| Output | Description |
|---------|-------------|
| `kms_key_id` | AWS KMS Key ID |
| `kms_key_arn` | AWS KMS Key ARN |
| `kms_alias` | AWS KMS Alias |
| `kms_policy` | Generated IAM policy |
| `rotation_enabled` | Key rotation status |
| `multi_region` | Multi-Region configuration |

---


> **Note:** The KMS module uses Terraform lifecycle protection (`prevent_destroy`) to reduce the risk of accidental deletion of customer-managed encryption keys. Remove this protection only as part of an approved decommissioning process.

---



## Summary

This deployment example demonstrates the implementation of a reusable enterprise encryption platform using AWS Key Management Service. It establishes the cryptographic foundation of the Zero Trust Reference Architecture by providing centralized key management, standardized security controls, and reusable infrastructure that can be consumed by subsequent application and infrastructure deployments.