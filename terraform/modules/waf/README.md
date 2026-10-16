cd /mnt/c/Users/ogund/github/zero-trust-reference-architecture/terraform

cat > modules/waf/README.md <<'EOF'
# Enterprise Web Application Firewall Module

## Overview

The Enterprise Web Application Firewall module provisions the core infrastructure required to protect internet-facing applications and APIs within the Zero Trust Reference Architecture.

The module deploys an AWS WAFv2 Web ACL with managed rule groups, rate-based protection, IP-based controls, and centralized logging. WAF security events are captured through Amazon CloudWatch Logs using a customer-managed AWS Key Management Service (KMS) key for encryption at rest.

All resources are provisioned using Terraform and follow enterprise security best practices, including least-privilege IAM permissions, encryption at rest, automatic KMS key rotation, standardized resource tagging, and reusable infrastructure-as-code design.

---

## Features

- Deploys an AWS WAFv2 Web ACL.
- Supports REGIONAL and CLOUDFRONT WAF scopes.
- Supports AWS Managed Rules rule groups.
- Provides rate-based request protection.
- Supports IP allow lists.
- Supports IP block lists.
- Configures WAF logging to Amazon CloudWatch Logs.
- Encrypts WAF logs using a customer-managed AWS KMS key.
- Enables automatic KMS key rotation.
- Creates a KMS alias for simplified key management.
- Configures the required CloudWatch Logs resource policy.
- Supports enterprise tagging standards.
- Designed for reusable enterprise deployments.
- Compatible with Terraform 1.13 or later.

---

## Architecture

```text
                    Internet
                       │
                       ▼
              Application / API
                       │
                       ▼
                 AWS WAFv2
                  Web ACL
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
     Managed Rules  Rate Limit   IP Controls
          │            │            │
          └────────────┼────────────┘
                       │
                       ▼
               Protected Workload


                 AWS WAF Logging
                       │
                       ▼
             CloudWatch Log Group
                       │
                       ▼
                AWS KMS CMK
                       │
                       ▼
              Encrypted Log Data

---

## Module Structure

modules/
└── waf/
    ├── versions.tf
    ├── provider.tf
    ├── variables.tf
    ├── locals.tf
    ├── main.tf
    ├── kms.tf
    ├── policy.tf
    ├── outputs.tf
    └── README.md
