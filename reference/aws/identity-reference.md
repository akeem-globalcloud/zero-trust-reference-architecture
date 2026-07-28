# AWS Identity Reference

## Purpose

This document describes how the Zero Trust Reference Architecture is implemented using AWS identity and access management services.

The objective is to establish a secure, scalable, and reusable identity model that supports enterprise cloud environments while enforcing Zero Trust principles.

This guidance is intended as a reference implementation and can be adapted to organizations operating across federal, financial services, healthcare, energy, manufacturing, and other regulated industries.

---

# Design Goals

The identity architecture is designed to:

- Verify every identity.
- Enforce least privilege.
- Centralize identity management.
- Eliminate long-lived credentials.
- Support workforce and workload identities.
- Enable federation with enterprise identity providers.
- Improve auditability.

---

# AWS Identity Services

| Service | Purpose |
|----------|----------|
| IAM | Identity and access management |
| IAM Identity Center | Workforce authentication and authorization |
| AWS Organizations | Multi-account governance |
| AWS STS | Temporary credentials |
| IAM Roles | Delegated access |
| IAM Policies | Fine-grained authorization |
| KMS | Cryptographic key protection |
| CloudTrail | Identity auditing |

---

# Identity Types

The architecture recognizes four identity categories.

## Workforce Identities

Human users including:

- Administrators
- Developers
- Security Engineers
- Auditors
- Operations Teams

Authentication is performed through a centralized identity provider using federation.

---

## Workload Identities

Application components such as:

- EC2
- Lambda
- ECS
- EKS
- Step Functions

Authentication is performed using IAM Roles instead of long-lived access keys.

---

## Service Identities

AWS managed services communicate using service roles with explicitly defined permissions.

---

## External Identities

Partners, vendors, and third-party systems access resources through tightly controlled federation and cross-account roles.

---

# Authentication Strategy

Authentication should prioritize:

- Federated login
- Multi-factor authentication
- Temporary credentials
- Passwordless authentication where supported

Root account usage should be limited to emergency administrative activities.

---

# Authorization Strategy

Authorization follows:

- Least privilege
- Role-Based Access Control (RBAC)
- Attribute-Based Access Control (ABAC)
- Separation of duties

Permissions should be granted through reusable IAM roles rather than directly to users.

---

# Cross-Account Access

Cross-account access should use:

- AWS Organizations
- IAM Roles
- AWS STS
- Resource-based policies where appropriate

Long-lived cross-account access keys should not be used.

---

# Logging and Auditing

Identity activity should be monitored using:

- AWS CloudTrail
- AWS Config
- Amazon GuardDuty
- AWS Security Hub

All authentication and authorization events should be logged and retained according to organizational policy.

---

# Reference Architecture

The identity architecture supports:

- Centralized authentication
- Decentralized authorization
- Temporary credentials
- Continuous verification
- Identity federation
- Automated auditing

Subsequent implementation stories will translate this guidance into reusable Terraform modules and IAM policies.
