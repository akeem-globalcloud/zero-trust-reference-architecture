# ADR-005: Enterprise Data Protection & Cryptography

## Status

Completed

---

## Context

The Zero Trust Reference Architecture requires a centralized cryptographic service to protect sensitive enterprise data and provide consistent encryption across cloud workloads.

Applications, storage services, databases, and secrets management require customer-managed encryption keys that support centralized governance, lifecycle management, least-privilege access, auditing, and regulatory compliance.

Managing encryption independently within individual applications introduces inconsistent security controls, increases operational complexity, and makes enterprise compliance difficult to enforce.

---

## Decision

Adopt **AWS Key Management Service (AWS KMS)** as the enterprise cryptographic service and implement it as a reusable Terraform module.

The implementation will provision:

- Customer Managed Keys (CMKs)
- KMS aliases
- Least-privilege IAM key policies
- Automatic key rotation
- Configurable Multi-Region support
- Enterprise tagging
- Lifecycle protection (`prevent_destroy`)
- Extensible policy documents
- AWS service principal integration

The deployment will serve as the standard encryption pattern for all infrastructure components within the Zero Trust Reference Architecture.

---

## Rationale

AWS KMS provides a managed, highly available, and scalable key management platform that integrates natively with AWS services.

Key advantages include:

- Centralized key management
- Automatic key rotation
- Native AWS service integration
- IAM-based authorization
- CloudTrail audit logging
- High availability
- Regulatory compliance support
- Reduced operational overhead

Implementing KMS as a reusable Terraform module ensures consistent deployment standards across environments while supporting Infrastructure as Code practices.

---

## Consequences

### Positive

- Centralized cryptographic governance
- Standardized encryption across workloads
- Reduced operational complexity
- Improved auditability
- Enterprise tagging consistency
- Reusable Terraform module
- Supports future workloads without redesign

### Negative

- Customer-managed keys incur AWS KMS charges.
- Key deletion requires administrative controls.
- Poorly designed IAM policies may prevent workload access.
- Multi-Region keys increase management complexity.

---

## Alternatives Considered

### AWS Managed Keys

Rejected because they provide limited administrative control and cannot satisfy all enterprise governance requirements.

### CloudHSM

Rejected because it introduces additional operational complexity and cost that is unnecessary for the current architecture.

### External Key Store (XKS)

Rejected because external HSM integration is outside the scope of the current implementation and will be evaluated in future iterations.

### Application-Managed Encryption

Rejected because decentralized key management conflicts with Zero Trust principles and increases operational risk.

---

## Security Considerations

The implementation enforces:

- Least-privilege IAM policies
- Customer-managed encryption keys
- Automatic key rotation
- Lifecycle protection using `prevent_destroy`
- Enterprise tagging standards
- CloudTrail integration for auditing
- Explicit service principal authorization

---

## Compliance Alignment

This decision supports:

- NIST SP 800-53
- NIST Cybersecurity Framework (CSF)
- CIS AWS Foundations Benchmark
- HIPAA Security Rule
- PCI DSS
- ISO/IEC 27001
- SOC 2

---

## Implementation

Terraform Module:

```text
terraform/modules/kms-data-protection/