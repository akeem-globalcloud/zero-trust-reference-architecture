# ADR-010: Adopt Enterprise Web Application Firewall

## Status

Accepted

**Epic:** Zero-Trust Reference Architecture

---

## Context

Enterprise web applications are continuously exposed to malicious internet traffic, automated attacks, application-layer threats, unauthorized access attempts, and common web vulnerabilities. As organizations adopt cloud-native and internet-facing workloads, relying solely on network security controls is insufficient to protect applications at the HTTP and HTTPS layers.

Within a Zero Trust architecture, application traffic must be continuously inspected and evaluated before being allowed to reach protected workloads. Security controls should operate independently of network location and should enforce explicit security policies based on the characteristics of incoming requests.

AWS provides AWS WAF as a managed web application firewall capable of inspecting HTTP and HTTPS requests and applying configurable security rules before traffic reaches protected applications.

However, an enterprise WAF implementation requires more than simply enabling a Web ACL. The architecture must provide managed rule groups, configurable access controls, rate limiting, centralized logging, encryption, and appropriate resource policies while maintaining least-privilege access.

The architecture therefore requires a reusable WAF capability that can protect enterprise applications against common web threats while providing centralized visibility, controlled access, and secure logging.

---

## Decision

The Zero Trust Reference Architecture adopts AWS WAF as the primary application-layer protection mechanism for internet-facing web workloads.

The solution consists of:

- AWS WAFv2 Web ACL for application-layer traffic inspection.
- AWS Managed Rules for protection against common web threats.
- Rate-based rules for controlling excessive request rates.
- IP allow and block controls for explicit traffic management.
- AWS CloudWatch Logs for centralized WAF logging.
- AWS KMS Customer Managed Key (CMK) for encryption of WAF log data.
- AWS IAM and resource policies implementing least-privilege access.
- Terraform modules for repeatable Infrastructure as Code deployments.
- Enterprise tagging for consistent resource governance.

The WAF Web ACL is configured with a default action and additional security rules that evaluate incoming requests before they reach the protected application.

Managed rule groups provide protection against common application-layer attack patterns, while rate-based controls help mitigate excessive or abusive request activity.

WAF logging is enabled to provide visibility into allowed and blocked requests. CloudWatch log data is encrypted using a dedicated customer-managed KMS key with automatic key rotation enabled.

The resulting implementation provides a reusable enterprise WAF capability that can be integrated with supported AWS resources such as Application Load Balancers, API Gateway APIs, and Amazon CloudFront distributions.

---

## Decision Drivers

The following architectural drivers influenced this decision:

- Application-layer threat protection
- Continuous web traffic inspection
- Protection against common web attacks
- Rate-based traffic control
- Explicit IP allow and block capabilities
- Centralized WAF logging
- Encryption of security logs
- Least-privilege access control
- Modular Infrastructure as Code
- Enterprise scalability
- Operational simplicity
- Native AWS service integration
- Zero Trust alignment
- Defense in depth
- Regulatory and security compliance

---

## Alternatives Considered

### Alternative 1 – Application-Only Security Controls

Rely entirely on application code and application frameworks to identify and block malicious web requests.

**Rejected**

Reason:

- Security controls are dependent on individual applications.
- Requires application-specific implementations.
- Increases development and maintenance requirements.
- Does not provide a centralized web traffic security layer.
- Security policies may be inconsistently implemented across applications.

---

### Alternative 2 – Network Firewall Only

Use network-level firewall controls as the primary protection mechanism for web applications.

**Rejected**

Reason:

- Network firewalls primarily operate at lower network layers.
- Application-layer HTTP and HTTPS inspection requires additional controls.
- Does not provide the same application-aware rule capabilities as AWS WAF.
- Requires additional mechanisms for common web attack protection.

---

### Alternative 3 – Third-Party Web Application Firewall

Deploy a third-party WAF solution to provide application-layer protection.

**Rejected**

Reason:

- Introduces additional infrastructure and vendor dependencies.
- May increase operational complexity.
- Requires additional integration and management.
- Can increase licensing and operational costs.
- Reduces the use of native AWS security capabilities.

---

### Selected Architecture

AWS WAFv2 Web ACL

↓

Managed and Custom WAF Rules

↓

Rate-Based and IP Access Controls

↓

Protected AWS Application

↓

CloudWatch WAF Logs

↓

AWS KMS Customer Managed Key

This architecture provides a managed application-layer security control while maintaining centralized visibility, encryption, and enterprise governance.

---

## Architectural Consequences

### Positive Consequences

- Continuous application-layer traffic inspection.
- Protection against common web application threats.
- Managed AWS security rules.
- Rate-based request protection.
- Explicit IP allow and block controls.
- Centralized WAF logging.
- Encrypted security logs.
- Automatic KMS key rotation.
- Reduced operational overhead.
- Modular Terraform implementation.
- Reusable enterprise architecture.
- Improved application security posture.
- Consistent security controls across deployments.

### Trade-offs

- Requires additional AWS WAF configuration and management.
- Additional AWS WAF and logging costs.
- Requires ongoing review of WAF rules.
- Incorrect rules may affect legitimate application traffic.
- Requires KMS and logging policy management.
- Application-specific tuning may be required for complex workloads.

---

## Security Considerations

The architecture follows Zero Trust security principles by:

- Inspecting application traffic before allowing access to protected workloads.
- Applying explicit WAF security rules.
- Using managed rule groups to detect common web threats.
- Applying rate-based controls to reduce abusive traffic.
- Supporting explicit IP allow and block controls.
- Logging WAF activity for security monitoring and investigation.
- Encrypting WAF logs using a customer-managed KMS key.
- Enabling automatic KMS key rotation.
- Restricting access to the KMS key through controlled IAM and service policies.
- Applying least-privilege permissions.
- Eliminating hard-coded credentials.
- Supporting Infrastructure as Code for repeatable deployments.
- Applying enterprise resource tagging standards.

The WAF logging architecture uses a dedicated CloudWatch log group and customer-managed KMS key to protect security log data at rest.

The KMS key policy provides the permissions required for AWS service integration while restricting service access through appropriate principals and conditions.

The WAF logging resource policy is similarly restricted to the required AWS logging service actions and the designated CloudWatch log group.

---

## Compliance Alignment

This decision supports:

- NIST SP 800-207 (Zero Trust Architecture)
- NIST SP 800-53
- CIS AWS Foundations Benchmark
- AWS Well-Architected Framework – Security Pillar
- Principle of Least Privilege
- Defense in Depth
- Secure application architecture
- Continuous security monitoring

---

## Risks

| Risk | Mitigation |
|------|------------|
| Legitimate traffic is blocked | Test and tune WAF rules before production deployment |
| WAF rules become outdated | Review managed and custom rules periodically |
| Excessive requests impact applications | Configure rate-based rules based on application requirements |
| Unauthorized traffic reaches applications | Apply IP restrictions and managed WAF rules |
| WAF logs contain sensitive security information | Encrypt CloudWatch logs using a customer-managed KMS key |
| Unauthorized access to WAF logging | Restrict IAM and CloudWatch resource policies |
| Incorrect rule configuration | Validate Terraform configuration and review Terraform plans before deployment |
| WAF logging failure | Monitor CloudWatch logging configuration and AWS service health |
| KMS access denied | Review KMS key policy, service conditions, and IAM permissions |

---

## Future Enhancements

Future stories may extend this architecture by integrating:

- AWS Security Hub
- Amazon GuardDuty
- Amazon CloudWatch
- AWS Firewall Manager
- AWS Shield Advanced
- Amazon CloudFront
- AWS Network Firewall
- AWS Config
- Lambda-based automated remediation
- SIEM integration
- Security Operations Center (SOC) workflows
- ServiceNow integration
- Jira ticket creation
- Cross-account WAF management
- Centralized WAF governance
- Multi-Region WAF deployments
- Advanced threat intelligence integrations

---

## Validation

The WAF implementation is validated using Infrastructure as Code and security scanning tools.

| Validation | Status |
|------------|--------|
| terraform fmt | Passed |
| terraform validate | Passed |
| terraform plan | Passed |
| Checkov | Passed |
| Trivy Configuration Scan | Passed |

Checkov validation confirms that the WAF implementation satisfies the applicable security controls, including WAF rule configuration, WAF logging, CloudWatch log retention, IAM policy restrictions, and WAF logging configuration.

The implementation also addresses CloudWatch log retention and KMS encryption requirements for WAF logging.

---

## Implementation Scope

The Enterprise Web Application Firewall implementation provides the following capabilities:

- AWS WAFv2 Web ACL.
- Regional WAF deployment.
- Default WAF traffic action.
- AWS managed rule groups.
- Rate-based request protection.
- IP address allow lists.
- IP address block lists.
- WAF logging.
- CloudWatch log group.
- CloudWatch log retention.
- Customer-managed KMS encryption.
- Automatic KMS key rotation.
- KMS alias management.
- WAF logging resource policy.
- Enterprise resource tagging.
- Terraform-based deployment.

The module is designed to be reusable across enterprise workloads while allowing deployment-specific configuration through Terraform variables.

---

## Deployment Architecture

```text
                    Internet Traffic
                           │
                           ▼
                  ┌─────────────────┐
                  │    AWS WAFv2    │
                  │    Web ACL      │
                  └────────┬────────┘
                           │
              ┌────────────┼────────────┐
              │            │            │
              ▼            ▼            ▼
        Managed Rules   Rate Limit   IP Controls
              │            │            │
              └────────────┼────────────┘
                           │
                           ▼
                  Protected Application
                           │
                           │
                           ▼
                  WAF Logging Pipeline
                           │
                           ▼
                 CloudWatch Log Group
                           │
                           ▼
              AWS KMS Customer Managed Key


## Conclusion

This architectural decision establishes AWS WAF as the application-layer security control for the Zero Trust Reference Architecture.
By combining AWS WAFv2, managed rule groups, rate-based controls, IP access controls, CloudWatch logging, AWS KMS, IAM, and Terraform, the solution provides a secure and reusable mechanism for protecting enterprise web applications.
The architecture supports continuous inspection of application traffic while providing centralized visibility into WAF activity. Security logs are protected through customer-managed encryption, and access is controlled through least-privilege service and IAM policies.
The resulting WAF capability provides a foundational application security layer that can be extended with AWS Firewall Manager, AWS Shield Advanced, Security Hub, SIEM platforms, automated remediation, and centralized enterprise governance in future stories.
