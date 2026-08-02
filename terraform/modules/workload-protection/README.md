# Enterprise Workload Protection Module

## Overview

This module deploys a secure Amazon EC2 workload following Zero Trust and enterprise security best practices. It provisions a hardened EC2 instance with an IAM instance profile, encrypted storage, Instance Metadata Service Version 2 (IMDSv2), Systems Manager integration, enterprise tagging, and configurable monitoring.

The module is designed to be reusable across development, testing, and production environments while maintaining a consistent security baseline.

---

## Features

- Secure Amazon EC2 deployment
- IAM instance profile with AWS Systems Manager access
- Enforced IMDSv2
- Encrypted Amazon EBS root volume
- Configurable detailed monitoring
- Enterprise security group
- Enterprise tagging
- Configurable workload metadata
- Reusable module interface

---

## Architecture

```
                 +----------------------+
                 |   Amazon EC2         |
                 +----------+-----------+
                            |
          +-----------------+------------------+
          |                                    |
   IAM Instance Profile                 Security Group
          |                                    |
          |                                    |
 AWS Systems Manager                 VPC Network Controls
          |
          |
   Encrypted EBS Volume
          |
          |
      AWS KMS
```

---

## Resources Created

- AWS EC2 Instance
- Security Group
- IAM Role
- IAM Instance Profile
- IAM Role Policy Attachment

---

## Requirements

| Requirement | Version |
|------------|---------|
| Terraform | >= 1.13 |
| AWS Provider | ~> 6.0 |

---

## Module Inputs

| Name | Description |
|------|-------------|
| workload | Enterprise workload configuration object |

---

## Module Outputs

| Output | Description |
|--------|-------------|
| instance_id | EC2 instance ID |
| instance_arn | EC2 ARN |
| private_ip | Private IP address |
| security_group_id | Security group ID |
| iam_role_name | IAM role name |
| instance_profile | IAM instance profile |

---

## Security Controls

This module implements multiple enterprise security controls including:

- IAM least privilege
- IMDSv2 enforcement
- Encrypted root storage
- Systems Manager management
- Enterprise tagging
- No default public exposure
- Configurable detailed monitoring
- Enterprise network isolation

---

## Deployment

Use the deployment example located in:

```
terraform/deployment-examples/workload-protection
```

---

## Validation

Validate the deployment using:

```bash
terraform fmt -recursive

terraform init

terraform validate

terraform plan
```

Security validation:

```bash
checkov -d terraform/deployment-examples/workload-protection
```

Current validation results:

- Passed: 26
- Failed: 2
- Skipped: 0

The remaining findings relate to configurable module inputs and should be reviewed when updating the module or Checkov version.

---

## Enterprise Use Cases

- Zero Trust environments
- HIPAA workloads
- PCI DSS workloads
- Financial services
- Government workloads
- Enterprise landing zones

---

## License

Internal Enterprise Reference Architecture
