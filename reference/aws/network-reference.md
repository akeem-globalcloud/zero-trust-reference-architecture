# AWS Enterprise Network Reference

## Overview

This document describes the AWS networking services, design patterns, and implementation guidance used by the Enterprise Zero Trust Reference Architecture.

It translates the vendor-neutral networking principles into AWS-native services and provides a reference implementation that supports secure, scalable, and reusable cloud networking.

---

# Design Goals

The AWS network architecture is designed to:

- Minimize attack surface
- Support Zero Trust principles
- Enable multi-account deployments
- Isolate workloads
- Prefer private connectivity
- Scale across enterprise environments
- Support Infrastructure as Code

---

# Core AWS Services

## AWS Organizations

Provides logical separation of workloads into dedicated AWS accounts.

Recommended accounts include:

- Shared Services
- Production
- Development
- Security
- Logging
- Networking

---

## Amazon VPC

The Virtual Private Cloud provides network isolation for workloads.

Each account should contain one or more VPCs designed around business and security requirements.

---

## Subnet Strategy

Recommended subnet tiers:

- Public
- Private Application
- Private Data
- Management

Public subnets should contain only internet-facing resources.

Private subnets should host application and data workloads.

---

## Internet Gateway

Provides internet connectivity for public resources.

Should only be attached to VPCs requiring external access.

---

## NAT Gateway

Allows private resources to initiate outbound internet connections while preventing inbound internet access.

Recommended for:

- Package updates
- External API calls
- Patch management

---

## Transit Gateway

Provides centralized routing between VPCs and hybrid networks.

Benefits include:

- Simplified routing
- Reduced peering complexity
- Scalable multi-account connectivity

---

## VPC Endpoints

Use Gateway and Interface Endpoints to access AWS services without traversing the public internet.

Recommended endpoints include:

- Amazon S3
- AWS Systems Manager
- AWS Secrets Manager
- AWS KMS
- Amazon CloudWatch
- AWS STS

---

## Security Groups

Use Security Groups as stateful firewalls.

Recommendations:

- Default deny inbound
- Restrict outbound traffic where practical
- Reference Security Groups instead of broad CIDR ranges

---

## Network ACLs

Use Network ACLs for subnet-level filtering and defense in depth.

---

## Route Tables

Separate routing for:

- Public subnets
- Private application subnets
- Private data subnets
- Management subnets

---

## DNS

Use Amazon Route 53 and Route 53 Resolver for internal name resolution and hybrid DNS integration.

---

# High Availability

Deploy networking resources across multiple Availability Zones.

Avoid single points of failure.

---

# Security Considerations

- Prefer private communication
- Encrypt traffic in transit
- Restrict administrative access
- Enable VPC Flow Logs
- Monitor network activity continuously

---

# Relationship to Terraform

The networking patterns described in this document are implemented by:

```
terraform/modules/network/
```

Example deployments are located in:

```
terraform/examples/network-basic/
```

---

# Summary

This reference provides AWS-specific implementation guidance for the Enterprise Network & Connectivity Architecture and serves as the blueprint for the reusable Terraform networking module.
