# Enterprise Security Information & Event Management (SIEM) Deployment

## Overview

This deployment demonstrates how to provision the **Enterprise Security Information & Event Management (SIEM)** module using Terraform.

The deployment enables centralized security monitoring by integrating AWS Security Hub, Amazon EventBridge, Amazon SNS, AWS KMS, IAM, and Amazon CloudWatch into an enterprise-ready Security Operations (SOC) workflow.

This example serves as a reference implementation for organizations adopting Zero Trust security principles in AWS.

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

# Prerequisites

Before deploying this example, ensure you have:

- Terraform >= 1.13
- AWS CLI configured
- Appropriate AWS IAM permissions
- An AWS account with Security Hub supported in the selected region

---

# Deployment Structure

```
deployment-examples/
└── siem/
    ├── provider.tf
    ├── versions.tf
    ├── variables.tf
    ├── terraform.tfvars
    ├── main.tf
    ├── outputs.tf
    └── README.md
```

---

# Deployment Configuration

Example `terraform.tfvars`

```hcl
aws_region = "us-east-1"

siem = {

  name = "enterprise"

  securityhub = {
    enable_default_standards = true
  }

  eventbridge = {
    enabled = true
  }

  sns = {
    enabled       = true
    topic_name    = "enterprise-siem-findings"
    email_address = "security@example.com"
  }

  tags = {
    Environment = "Production"
    Owner       = "Cloud Security"
    Project     = "Zero Trust Reference Architecture"
  }
}
```

---

# Initialize Terraform

```bash
terraform init
```

---

# Format Configuration

```bash
terraform fmt -recursive
```

---

# Validate Configuration

```bash
terraform validate
```

---

# Review Deployment Plan

```bash
terraform plan
```

---

# Deploy

```bash
terraform apply
```

---

# Destroy

```bash
terraform destroy
```

---

# Expected Outputs

After deployment, Terraform returns:

- Security Hub Account ID
- EventBridge Rule Name
- SNS Topic ARN
- CloudWatch Log Group
- EventBridge IAM Role ARN
- AWS KMS Key ARN
- AWS KMS Alias

---

# Validation

The deployment has been validated using:

- Terraform fmt
- Terraform validate
- Terraform plan
- Checkov
- Trivy

---

# Security Considerations

This deployment implements:

- Customer-managed AWS KMS encryption
- Least-privilege IAM permissions
- Event-driven security architecture
- Centralized security findings
- Continuous monitoring
- Enterprise tagging strategy

---

# Related Documentation

- Module README
- Story ZT-009 – Enterprise Security Information & Event Management (SIEM)
- ADR-009 – Adopt Enterprise SIEM
- Enterprise SIEM Architecture Diagram
