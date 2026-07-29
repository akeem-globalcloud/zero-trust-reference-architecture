# Network & Connectivity Example

## Overview

This example demonstrates how to deploy the Enterprise Network Module.

The deployment provisions a complete networking foundation consisting of:

- VPC
- Public Subnets
- Private Subnets
- Database Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- Network ACLs
- Amazon S3 Gateway Endpoint
- AWS Transit Gateway

---

## Architecture

```
terraform/examples/network-basic
        |
        |
        ▼
terraform/modules/network
        |
        ▼
AWS Infrastructure
```

---

## Files

```
network-basic/
├── versions.tf
├── providers.tf
├── variables.tf
├── terraform.tfvars
├── main.tf
├── outputs.tf
└── README.md
```

---

## Initialize

```bash
terraform init
```

---

## Format

```bash
terraform fmt -recursive
```

---

## Validate

```bash
terraform validate
```

---

## Plan

```bash
terraform plan
```

---

## Apply

```bash
terraform apply
```

---

## Destroy

```bash
terraform destroy
```

---

## Expected Resources

- 1 VPC
- Public Subnets
- Private Subnets
- Database Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- Network ACLs
- Amazon S3 Gateway Endpoint
- Transit Gateway

---

## Example Output

```
vpc_id = "vpc-xxxxxxxx"

public_subnets = [
  subnet-xxxxxxxx,
  subnet-yyyyyyyy
]

private_subnets = [
  subnet-aaaaaaaa,
  subnet-bbbbbbbb
]
```

---

## Notes

This example is intended for validation and testing the reusable Enterprise Network Module. For production deployments, customize the CIDR ranges, Availability Zones, tagging strategy, and security controls to align with your organization's standards.

---

## Next Steps

After validating this example, you can extend it by adding:

- AWS Network Firewall
- VPC Flow Logs
- AWS Cloud WAN
- Interface VPC Endpoints
- AWS Route 53 Resolver
- Inspection VPC
- Multi-account Transit Gateway

These enhancements align with enterprise Zero Trust networking patterns.
