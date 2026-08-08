# Enterprise Security Information & Event Management (SIEM)

## Overview

The **Enterprise Security Information & Event Management (SIEM)** module provides a centralized security monitoring capability for AWS environments by aggregating, correlating, and routing security findings from multiple AWS security services.

The module establishes the foundation for enterprise Security Operations Center (SOC) workflows by integrating AWS Security Hub, Amazon EventBridge, Amazon SNS, AWS KMS, IAM, and Amazon CloudWatch into a reusable Infrastructure as Code (IaC) implementation.

Designed using Zero Trust principles, the module enables continuous monitoring, secure event processing, centralized visibility, and scalable security operations across cloud-native environments.

---

# Objectives

- Deploy an enterprise SIEM foundation.
- Centralize security findings across AWS services.
- Aggregate security events using AWS Security Hub.
- Route security findings using Amazon EventBridge.
- Deliver real-time notifications using Amazon SNS.
- Secure security telemetry with AWS KMS.
- Apply least-privilege IAM permissions.
- Support continuous monitoring.
- Standardize deployment using Terraform.
- Provide a reusable enterprise security architecture.

---

# Architecture

```
                  AWS Security Sources

 CloudTrail
 AWS Config
 GuardDuty
 Inspector
 IAM Access Analyzer
 CloudWatch
 VPC Flow Logs

                │
                ▼

          AWS Security Hub

                │
                ▼

         Amazon EventBridge

                │
      ┌─────────┴─────────┐
      ▼                   ▼

 Amazon SNS         CloudWatch Logs

      │
      ▼

 Security Operations Team
```

---

# Features

- Enterprise Security Information & Event Management (SIEM)
- Centralized security finding aggregation
- Continuous security monitoring
- Event-driven security architecture
- Amazon EventBridge integration
- Amazon SNS notifications
- AWS KMS encryption
- Least-privilege IAM
- CloudWatch integration
- Enterprise tagging
- Infrastructure as Code using Terraform

---

# AWS Services

- AWS Security Hub
- Amazon EventBridge
- Amazon SNS
- AWS IAM
- AWS KMS
- Amazon CloudWatch
- AWS CloudTrail
- Amazon GuardDuty
- Amazon Inspector
- AWS Config

---

# Module Structure

```
siem/

├── main.tf
├── provider.tf
├── versions.tf
├── variables.tf
├── locals.tf
├── securityhub.tf
├── eventbridge.tf
├── sns.tf
├── kms.tf
├── iam.tf
├── cloudwatch.tf
├── outputs.tf
└── README.md
```

---

# Inputs

| Name | Description | Type |
|------|-------------|------|
| aws_region | AWS Region | string |
| siem | Enterprise SIEM configuration | object |

---

# Outputs

| Output | Description |
|---------|-------------|
| securityhub_account_id | Security Hub account identifier |
| sns_topic_arn | Amazon SNS Topic ARN |
| eventbridge_rule_name | EventBridge rule name |
| cloudwatch_log_group | CloudWatch log group |
| eventbridge_role_arn | IAM role ARN |
| kms_key_arn | Customer-managed KMS key ARN |
| kms_key_alias | Customer-managed KMS alias |

---

# Security Controls

The module implements the following security controls:

- Centralized security monitoring
- Security event aggregation
- Event-driven notification
- Customer-managed encryption keys
- Least-privilege IAM
- Secure CloudWatch logging
- Enterprise tagging
- Infrastructure as Code validation

---

# Validation

The module has been validated using:

- Terraform fmt
- Terraform validate
- Terraform plan
- Checkov
- Trivy

---

# Checkov Exceptions

The following exceptions are documented as part of the enterprise reference architecture:

| Check | Reason |
|--------|--------|
| CKV_AWS_109 | AWS KMS key policy follows the AWS-recommended key administration model. |
| CKV_AWS_111 | AWS KMS key management actions are intentionally granted to the owning AWS account. |
| CKV_AWS_356 | AWS KMS key policies require `Resource "*"` because the policy is attached directly to the KMS key. |

---

# Compliance Alignment

The module supports implementation of security controls aligned with:

- NIST SP 800-207 (Zero Trust Architecture)
- NIST SP 800-53
- NIST Cybersecurity Framework (CSF)
- CIS AWS Foundations Benchmark
- AWS Foundational Security Best Practices
- ISO/IEC 27001
- SOC 2
- HIPAA Security Rule
- PCI DSS

---

# Future Enhancements

Future releases will integrate the SIEM foundation with:

- Amazon Security Lake
- Amazon OpenSearch Service
- Enterprise AI Security Operations Assistant
- Automated security remediation
- Threat intelligence integration
- ServiceNow
- Jira
- Slack / Microsoft Teams

---

# Related Documentation

- Deployment Example
- Story ZT-009 – Enterprise Security Information & Event Management (SIEM)
- ADR-009 – Adopt Enterprise SIEM
- Enterprise SIEM Architecture Diagram
