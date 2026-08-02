# ADR-002: Adopt Multi-Account Network Segmentation

- **Status:** Completed

- **Story:** ZT-003 – Enterprise Network & Connectivity Architecture

---

# Context

Modern enterprises operate workloads across multiple business units, environments, cloud accounts, and regulatory boundaries. A single flat network architecture increases operational complexity, expands the attack surface, and makes it difficult to enforce least privilege and workload isolation.

Cloud-native environments require networking models that support secure segmentation, centralized governance, and scalable connectivity without sacrificing operational agility.

To support these goals, this repository requires a foundational networking strategy that can be reused across industries and cloud deployments.

---

# Decision

This repository adopts a **multi-account segmented network architecture** built on AWS Organizations, Amazon VPCs, and centralized connectivity services.

Key principles include:

- Separate workloads into dedicated AWS accounts.
- Isolate environments such as production, development, and shared services.
- Use dedicated VPCs as security boundaries.
- Prefer private communication paths over public internet connectivity.
- Centralize routing where appropriate.
- Design networks using least-privilege principles.
- Support Infrastructure as Code for all networking components.

---

# Rationale

## Improved Isolation

Dedicated AWS accounts reduce the blast radius of security incidents and simplify administrative boundaries.

## Reduced Lateral Movement

Segmentation limits unauthorized east-west traffic between workloads and environments.

## Operational Scalability

Independent accounts and VPCs allow teams to scale infrastructure without creating tightly coupled network designs.

## Centralized Governance

Shared networking services, inspection points, and routing policies can be managed consistently while allowing workload autonomy.

## Cloud-Native Alignment

The architecture aligns with modern cloud operating models that emphasize modularity, automation, and reusable infrastructure.

---

# Alternatives Considered

## Single Account / Flat Network

### Advantages

- Simpler initial deployment.
- Lower operational overhead for small environments.

### Disadvantages

- Limited isolation.
- Increased attack surface.
- Difficult governance.
- Poor scalability.

**Decision:** Rejected.

---

## Extensive VPC Peering

### Advantages

- Direct communication between VPCs.
- Familiar architecture for smaller deployments.

### Disadvantages

- Operational complexity increases rapidly.
- Route management becomes difficult.
- Limited scalability.

**Decision:** Rejected as the primary architecture.

---

## Multi-Account Segmented Architecture

### Advantages

- Strong isolation.
- Better scalability.
- Simplified governance.
- Supports Zero Trust principles.
- Compatible with enterprise landing zones.
- Reusable across industries.

### Disadvantages

- More planning required.
- Additional operational complexity.
- Requires centralized governance.

**Decision:** Accepted.

---

# Consequences

Future networking implementations must:

- Organize workloads into dedicated accounts.
- Separate production and non-production environments.
- Use dedicated VPCs.
- Prefer private connectivity.
- Minimize internet exposure.
- Implement centralized routing where appropriate.
- Design Terraform modules to be reusable across accounts and environments.

---

# Repository Impact

This decision affects:

- `terraform/modules/network/`
- `terraform/examples/network-basic/`
- `reference/aws/network-reference.md`
- `docs/architecture/enterprise-network-architecture.md`
- Future landing zone implementations.

---

# Related Documents

- `docs/architecture/enterprise-network-architecture.md`
- `docs/architecture/zero-trust-networking.md`
- `reference/aws/network-reference.md`

---

# Future Considerations

Subsequent stories will extend this decision through:

- Hybrid connectivity
- Network inspection
- Service-to-service authentication
- Network telemetry
- Automated policy enforcement
- Landing zone architecture

---

# References

- AWS Well-Architected Framework – Security Pillar
- AWS Organizations Best Practices
- AWS Transit Gateway Documentation
- NIST SP 800-207 – Zero Trust Architecture
- NIST SP 800-53 Rev. 5
- CIS Critical Security Controls

---

# Decision Summary

The Enterprise Zero Trust Reference Architecture adopts a **multi-account segmented network architecture** as the standard networking model for all future implementations.

This decision provides the foundation for scalable, secure, and reusable cloud networking aligned with Zero Trust principles.
