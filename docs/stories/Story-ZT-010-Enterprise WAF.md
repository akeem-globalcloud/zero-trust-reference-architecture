# ZT-010 – Enterprise Web Application Firewall

## Story Information

| Property | Value |
|----------|-------|
| Story ID | ZT-010 |
| Epic | Zero Trust Reference Architecture |
| Priority | High |
| Story Points | 8 |
| Status | Completed |

---

# User Story

**As a** Cloud Security Engineer, I want to deploy an enterprise Web Application Firewall using AWS WAFv2, managed rule groups, rate-based controls, IP-based access controls, Amazon CloudWatch Logs, AWS KMS, and Terraform,

**So that** web applications are continuously protected against common application-layer attacks, malicious traffic is controlled, security events are logged securely, and the solution supports Zero Trust principles and enterprise security requirements.

---

# Business Value

Modern enterprise applications are continuously exposed to application-layer threats including malicious requests, automated attacks, excessive request rates, and known web-based attack patterns.

Traditional network security controls alone do not provide sufficient protection against application-layer threats. An enterprise Web Application Firewall provides an additional security layer capable of inspecting HTTP and HTTPS requests before they reach protected applications.

This solution delivers an automated and reusable web application security capability that:

- Protects applications using AWS WAFv2.
- Applies AWS-managed rule groups for common application-layer threats.
- Provides rate-based protection against excessive request volumes.
- Supports IP-based access control.
- Provides centralized WAF logging through Amazon CloudWatch Logs.
- Encrypts WAF logs using a customer-managed AWS KMS key.
- Enables automatic KMS key rotation.
- Implements restrictive resource and service policies.
- Supports Infrastructure as Code (IaC) deployment using Terraform.
- Applies enterprise resource tagging standards.
- Aligns with Zero Trust Architecture and AWS security best practices.

---

# Acceptance Criteria

- AWS WAFv2 Web ACL is successfully deployed.
- The Web ACL contains associated security rules.
- AWS-managed rule groups are configured where applicable.
- Rate-based protection is configured.
- IP-based access controls are supported.
- WAF logging is enabled.
- WAF logs are delivered to an Amazon CloudWatch Log Group.
- CloudWatch WAF logs specify an appropriate retention period.
- WAF logs are encrypted using a customer-managed AWS KMS key.
- Automatic KMS key rotation is enabled.
- A KMS alias is configured for the WAF logging key.
- WAF logging permissions follow least-privilege principles.
- CloudWatch Logs access is restricted to the required AWS service.
- Terraform resources deploy successfully.
- `terraform fmt` completes successfully.
- `terraform validate` completes successfully.
- `terraform plan` completes without errors.
- Trivy configuration scanning completes successfully.
- Checkov security scanning completes successfully.
- Security findings identified by Checkov are remediated or documented where they represent AWS-required policy behavior.
- Enterprise tagging is applied to provisioned resources.

---

# ADR-010: Adopt Enterprise Web Application Firewall

## Status

Completed

---

## Context

Enterprise web applications are continuously exposed to application-layer threats including malicious HTTP requests, automated attacks, excessive request rates, known exploit patterns, and unauthorized sources.

As organizations adopt cloud-native architectures, application security must be implemented as an additional security layer rather than relying exclusively on network controls or application-level protections.

Within a Zero Trust architecture, traffic should not automatically be trusted simply because it originates from an otherwise trusted network. Application requests should be inspected and evaluated according to security policies before being allowed to reach protected workloads.

AWS WAFv2 provides a managed Web Application Firewall capability that can inspect HTTP and HTTPS requests and apply configurable security rules.

However, a production enterprise implementation also requires secure logging, encryption, access control, and Infrastructure as Code. WAF security events must be retained for investigation and monitoring while ensuring that security logs are protected from unauthorized access.

The architecture therefore requires an enterprise WAF capability that combines request inspection, managed security rules, traffic controls, secure logging, customer-managed encryption, and reusable Terraform automation.

---

## Decision

The Zero Trust Reference Architecture adopts AWS WAFv2 as the application-layer security control for protecting enterprise web applications.

The solution consists of:

- AWS WAFv2 Web ACL for application-layer traffic inspection.
- AWS-managed WAF rule groups for protection against common web threats.
- Rate-based rules for controlling excessive request volumes.
- IP-based access controls for restricting or allowing known sources.
- Amazon CloudWatch Logs for centralized WAF logging.
- AWS KMS Customer Managed Key (CMK) for encrypting WAF logs.
- AWS KMS automatic key rotation for improved key security.
- AWS KMS alias for simplified key management.
- AWS IAM and CloudWatch resource policies implementing least-privilege access.
- Terraform modules for repeatable Infrastructure as Code deployments.
- Enterprise tagging for consistent resource governance.

The WAF logging destination is encrypted using a dedicated customer-managed KMS key. The KMS key policy restricts service access through specific principals and service conditions.

WAF logging permissions are restricted to the AWS service required to deliver logs to the CloudWatch Log Group.

The implementation is designed as a reusable Terraform module so that the same security controls can be applied consistently across multiple enterprise workloads and environments.

---

## Decision Drivers

The following architectural drivers influenced this decision:

- Application-layer threat protection
- Continuous HTTP and HTTPS traffic inspection
- Managed security rules
- Rate-based traffic protection
- IP-based access control
- Secure security-event logging
- Encryption of WAF logs
- Least-privilege access control
- Customer-managed encryption keys
- Automatic KMS key rotation
- Modular Infrastructure as Code
- Enterprise scalability
- Operational simplicity
- Native AWS service integration
- Zero Trust alignment
- Regulatory and security compliance
- Reusable security architecture

---

## Alternatives Considered

### Alternative 1 – Application-Only Security Controls

Rely exclusively on application code to detect and block malicious web requests.

**Rejected**

Reason:

- Places the entire security burden on application developers.
- Increases application complexity.
- Provides inconsistent protection across applications.
- May allow malicious traffic to reach application infrastructure before detection.
- Does not provide centralized WAF policy management.

---

### Alternative 2 – Network Firewall Only

Use network-layer controls as the primary security mechanism for protecting web applications.

**Rejected**

Reason:

- Network controls do not provide equivalent application-layer HTTP inspection.
- Cannot independently address many web application attack patterns.
- Does not provide the same managed WAF rule capabilities.
- Requires additional application-layer controls.

---

### Alternative 3 – Third-Party Web Application Firewall

Deploy a third-party WAF platform instead of AWS WAFv2.

**Rejected**

Reason:

- Introduces additional external dependencies.
- Increases operational complexity.
- May introduce additional licensing costs.
- Requires integration with AWS networking and application architectures.
- Reduces the simplicity of a native AWS security architecture.

---

### Selected Architecture

AWS WAFv2

↓

Managed Rule Groups / Rate-Based Rules / IP Controls

↓

Protected Web Application

↓

CloudWatch WAF Logs

↓

AWS KMS Customer Managed Key

This architecture provides a managed application-layer security control while maintaining secure logging, encryption, centralized governance, and Infrastructure as Code.

---

## Architectural Consequences

### Positive Consequences

- Provides application-layer traffic protection.
- Protects applications against common web attack patterns.
- Supports managed AWS security rules.
- Provides rate-based traffic protection.
- Enables IP-based access controls.
- Provides centralized WAF logging.
- Encrypts security logs using a customer-managed KMS key.
- Enables automatic KMS key rotation.
- Reduces operational overhead through managed AWS services.
- Provides reusable Terraform infrastructure.
- Improves consistency across enterprise deployments.
- Supports Zero Trust security principles.
- Provides a foundation for future SIEM and security automation integrations.

### Trade-offs

- Requires WAF rule management and periodic review.
- AWS WAF introduces additional AWS service costs.
- Customer-managed KMS keys introduce additional management requirements.
- WAF policies must be tuned to minimize false positives.
- Application teams may need to coordinate with security teams when modifying WAF rules.
- WAF logging introduces additional CloudWatch Logs storage and retention costs.

---

## Security Considerations

The architecture follows Zero Trust security principles by:

- Inspecting application traffic using AWS WAFv2.
- Applying explicit WAF security rules.
- Using AWS-managed rule groups where appropriate.
- Applying rate-based controls to limit excessive traffic.
- Supporting IP-based access control.
- Logging WAF security events for monitoring and investigation.
- Encrypting WAF logs using a customer-managed AWS KMS key.
- Enabling automatic KMS key rotation.
- Restricting CloudWatch Logs access to the required AWS service.
- Applying least-privilege resource policies.
- Restricting KMS service access using service-specific conditions.
- Eliminating hard-coded credentials.
- Supporting Infrastructure as Code for repeatable deployments.
- Applying enterprise tagging standards.

The CloudWatch Log Group is configured with an explicit retention period to support security monitoring and investigation requirements.

The KMS key is dedicated to WAF log encryption and has automatic rotation enabled.

The KMS key policy is designed to provide the required administrative permissions while restricting service-level access through appropriate principals and conditions.

---

## Compliance Alignment

This decision supports:

- NIST SP 800-207 (Zero Trust Architecture)
- NIST SP 800-53
- CIS AWS Foundations Benchmark
- AWS Well-Architected Framework – Security Pillar
- Principle of Least Privilege
- Defense in Depth
- Continuous Monitoring
- Secure Logging and Monitoring
- Data Protection
- Infrastructure as Code Governance

---

## Risks

| Risk | Mitigation |
|------|------------|
| WAF rules incorrectly block legitimate traffic | Perform rule tuning and monitor WAF logs |
| Malicious traffic bypasses WAF | Apply defense-in-depth controls and secure application architecture |
| Excessive request volume impacts applications | Configure rate-based rules |
| Unauthorized access to WAF logs | Restrictive CloudWatch Logs resource policy |
| Unauthorized KMS access | Restrictive KMS key policy and service conditions |
| Log retention is insufficient | Configure enterprise-approved CloudWatch retention |
| WAF configuration drift | Manage configuration through Terraform |
| False positives from managed rules | Monitor blocked requests and tune rule exclusions where necessary |
| WAF logging failure | Monitor CloudWatch logging configuration and service permissions |

---

## Future Enhancements

Future stories may extend this architecture by integrating:

- AWS Shield Advanced
- AWS Security Hub
- Amazon GuardDuty
- Amazon CloudWatch dashboards
- Amazon CloudWatch alarms
- Centralized SIEM integration
- Security Operations Center (SOC) workflows
- Automated WAF rule remediation
- AWS Lambda-based security automation
- Cross-account WAF logging
- Multi-Region WAF deployment
- Centralized security logging
- AWS Firewall Manager
- Automated threat intelligence integration
- Incident response workflows

---

## Conclusion

This architectural decision establishes AWS WAFv2 as the application-layer security control within the Zero Trust Reference Architecture.

By combining AWS WAFv2, managed rule groups, rate-based controls, IP-based access controls, CloudWatch logging, AWS KMS, IAM policies, and Terraform, the solution provides a secure and reusable mechanism for protecting enterprise web applications.

The architecture supports continuous inspection of application traffic while providing centralized security visibility and controlled access to WAF security events.

Security logs are protected through customer-managed encryption, automatic KMS key rotation, explicit retention configuration, and restrictive service permissions.

The resulting WAF capability provides a foundational application security layer that can be extended with AWS Shield Advanced, Security Hub, SIEM platforms, automated remediation, centralized firewall management, and broader Zero Trust security controls in future stories.

---

# Deployment Information

## Deployment Overview

This deployment demonstrates how to provision the Enterprise Web Application Firewall solution within the Zero Trust Reference Architecture using the reusable Terraform WAF module.

The deployment creates an AWS WAFv2 Web ACL with enterprise security controls and configures secure WAF logging through Amazon CloudWatch Logs.

WAF logs are encrypted using a customer-managed AWS KMS key with automatic key rotation enabled.

The deployment is intended to serve as a reusable reference implementation that can be adapted for enterprise workloads while maintaining consistent security controls, Infrastructure as Code practices, and Zero Trust principles.

---

## Prerequisites

Before deploying the solution, ensure the following requirements are met.
- Terraform 1.13 or later
- AWS Provider version 6.x
- AWS CLI configured
- Valid AWS credentials
- Permissions to create AWS WAFv2 resources
- Permissions to create CloudWatch Log Groups
- Permissions to create AWS KMS keys and aliases
- Permissions to create CloudWatch Logs resource policies
- Appropriate IAM permissions
- A supported AWS Region

---

# Resources Created
The deployment provisions the following AWS resources.

| Resource | Description |
|----------|-------------|
| AWS WAFv2 Web ACL | Provides application-layer traffic inspection and protection |
| AWS WAFv2 Rules | Applies security controls to web traffic |
| AWS Managed Rule Groups | Provides protection against common web threats |
| Rate-Based Rules | Controls excessive request rates |
| IP-Based Controls | Provides source IP access control |
| CloudWatch Log Group | Stores WAF security and traffic logs |
| AWS KMS Key | Encrypts WAF CloudWatch Logs |
| AWS KMS Alias | Provides a friendly alias for the encryption key |
| KMS Key Policy | Controls administrative and service access to the key |
| CloudWatch Log Resource Policy | Allows the required AWS service to deliver WAF logs |
| WAF Logging Configuration | Connects AWS WAF to CloudWatch Logs |

---

## Verification
After deployment, verify the following.
Terraform
terraform state list

Expected resources should include resources associated with:
- aws_wafv2_web_acl
- aws_wafv2_web_acl_logging_configuration
- aws_cloudwatch_log_group
- aws_cloudwatch_log_resource_policy
- aws_kms_key
- aws_kms_alias
- aws_kms_key_policy

## AWS Console
Confirm the following resources exist.

# AWS WAF
- Web ACL is deployed.
- Web ACL is associated with the intended protected resource where applicable.
- WAF rules are present.
- Managed rule groups are configured.
- Rate-based controls are configured.
- IP-based controls are configured where applicable.

# CloudWatch Logs
- WAF log group exists.
- WAF logging is enabled.
- Log retention is configured.
- WAF log events are being delivered.

# AWS KMS
- Customer-managed KMS key exists.
- Key rotation is enabled.
- KMS alias is configured.
- Key policy is attached.
- WAF logging uses the customer-managed key.

# Security Controls
The deployment implements the following enterprise security controls.
Application Security
- AWS WAFv2 application-layer protection.
- Managed AWS rule groups.
- Rate-based request controls.
- IP-based access controls.
- Explicit WAF rule actions.
- Continuous inspection of application traffic.

# Logging and Monitoring
- WAF logging enabled.
- CloudWatch Log Group configured for WAF events.
- Defined log retention period.
- Centralized security-event visibility.
- Logs available for security investigation and operational monitoring.
Encryption
- Customer-managed AWS KMS key.
- Automatic KMS key rotation.
- WAF logs encrypted at rest.
- Dedicated KMS alias.
- Restrictive KMS key policy.

# Identity and Access Management
- Least-privilege service permissions.
- Service-specific principals.
- Restrictive CloudWatch Logs resource policy.
- Restrictive KMS key policy.
- No hard-coded credentials.
- Explicit service conditions.

# Zero Trust
- Application traffic is inspected before reaching protected workloads.
- Access decisions are based on defined WAF security policies.
- Malicious and excessive traffic can be blocked automatically.
- Security events are continuously logged.
- Security logs are protected using customer-managed encryption.
- Infrastructure is managed through Terraform.
- Security controls are repeatable and version controlled.

---

## Validation
The deployment was validated using the following tools.
| Validation | Result |
|------------|--------|
| terraform fmt | Passed |
| terraform validate | Passed |
| terraform plan | Passed |
| Checkov | Passed |
| Trivy Configuration Scan | Passed |

---

## Troubleshooting
| Issue | Resolution |
|------|------------|
| Terraform initialization fails | Verify AWS credentials, AWS provider version, and network connectivity |
| Terraform validation fails | Review Terraform syntax and module references |
| Terraform plan reports duplicate data resources | Ensure `aws_caller_identity.current` and `aws_region.current` are declared only once within the WAF module |
| WAF logging fails | Verify the CloudWatch Log Group, logging configuration, and resource policy |
| WAF logs are not delivered | Confirm the CloudWatch Logs resource policy permits the required AWS service |
| KMS access denied | Review the KMS key policy and service-specific conditions |
| Checkov reports KMS policy findings | Review the KMS key policy and ensure administrative permissions and resource constraints are appropriately defined |
| WAF blocks legitimate traffic | Review WAF logs and tune managed rules or exclusions |
| Excessive traffic reaches the application | Review and tune rate-based rules |
| Trivy reports configuration findings | Review the affected Terraform resource and remediate the reported configuration |

---

## Operational Considerations
The WAF configuration should be reviewed periodically to ensure that rules remain aligned with application requirements and emerging threats.
Security teams should monitor:
- Blocked WAF requests.
- Allowed WAF requests.
- Rate-based rule activity.
- Managed rule group findings.
- IP-based rule activity.
- CloudWatch WAF logs.
- KMS key usage.
- Changes to WAF configuration.
- Changes to WAF logging configuration.
WAF rules should be tested before being deployed broadly to production workloads to reduce the possibility of legitimate application traffic being blocked.

---

## Future Enhancements
Future implementations may extend this deployment by integrating:
- AWS Shield Advanced
- AWS Firewall Manager
- AWS Security Hub
- Amazon GuardDuty
- Amazon CloudWatch dashboards
- Amazon CloudWatch alarms
- Centralized SIEM platforms
- Security Operations Center workflows
- Automated WAF rule remediation
- AWS Lambda security automation
- Cross-account WAF governance
- Multi-Region WAF deployment
- Centralized security logging
- Threat intelligence feeds
- Incident response automation
- ServiceNow integration
- Jira integration

---

# Deployment Architecture

```text
                    Internet / Client Traffic
                              │
                              ▼
                     AWS WAFv2 Web ACL
                              │
              ┌───────────────┼────────────────┐
              │               │                │
              ▼               ▼                ▼
        Managed Rules    Rate-Based Rules   IP Controls
              │               │                │
              └───────────────┼────────────────┘
                              │
                              ▼
                    Protected Application
                              │
                              │
                         WAF Logging
                              │
                              ▼
                  Amazon CloudWatch Logs
                              │
                              ▼
                  AWS KMS Customer Key
