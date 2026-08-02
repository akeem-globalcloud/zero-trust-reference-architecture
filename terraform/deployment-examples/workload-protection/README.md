# Enterprise Workload Protection Deployment

## Overview

As a Cloud Security Engineer, deploy secure Amazon EC2 workloads using reusable Terraform modules that enforce enterprise security controls, Zero Trust principles, and AWS security best practices.

This deployment provisions a hardened EC2 instance with encrypted storage, IAM instance profiles, Systems Manager integration, enterprise tagging, and configurable monitoring.

---

## Architecture

```
                  +----------------------------+
                  | Amazon EC2 Workload        |
                  +-------------+--------------+
                                |
              +-----------------+-----------------+
              |                                   |
     IAM Instance Profile                Security Group
              |                                   |
              |                                   |
      AWS Systems Manager                 Amazon VPC
              |
              |
      Encrypted EBS Volume
              |
              |
          AWS KMS
```

---

## Prerequisites

- Terraform >= 1.13
- AWS CLI configured
- AWS Provider ~> 6.0
- Existing Amazon VPC
- Existing subnet
- Valid Amazon Machine Image (AMI)

---

## Deployment Files

```
provider.tf
main.tf
variables.tf
terraform.tfvars
outputs.tf
```

---

## Configure Variables

Update the `terraform.tfvars` file with values appropriate for your environment.

Example configuration fields include:

- AWS Region
- AMI ID
- Instance type
- VPC ID
- Subnet ID
- Monitoring configuration
- Metadata configuration
- Enterprise tags

---

## Initialize Terraform

```bash
terraform init
```

---

## Validate Configuration

```bash
terraform validate
```

---

## Review Deployment

```bash
terraform plan
```

---

## Deploy Infrastructure

```bash
terraform apply
```

---

## Verify Deployment

Confirm the following resources are created successfully:

- EC2 Instance
- IAM Role
- IAM Instance Profile
- Security Group
- Encrypted Root Volume

Verify that:

- IMDSv2 is enabled
- Systems Manager can manage the instance
- EBS encryption is enabled
- Enterprise tags are applied
- Detailed monitoring is configured according to deployment requirements

---

## Security Validation

Run Checkov:

```bash
checkov -d .
```

Current validation results:

| Check | Result |
|--------|-------:|
| Passed | 26 |
| Failed | 2 |
| Skipped | 0 |

The remaining findings are associated with configurable module inputs and should be reviewed when upgrading Checkov or modifying the module implementation.

---

## Destroy Resources

```bash
terraform destroy
```

---

## Expected Resources

Deployment creates:

- Amazon EC2 Instance
- Amazon EC2 Security Group
- IAM Role
- IAM Instance Profile
- IAM Role Policy Attachment

---

## Enterprise Security Controls

- Zero Trust architecture
- Least privilege IAM
- IMDSv2 enforcement
- Encrypted EBS storage
- Systems Manager integration
- Enterprise tagging
- Configurable monitoring
- Private networking support
