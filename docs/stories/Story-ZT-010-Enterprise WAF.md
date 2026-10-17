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

**As a Cloud Security and Infrastructure Engineer,** I want to deploy an enterprise Web Application Firewall using AWS WAFv2, managed rule groups, rate-based controls, IP-based access controls, Amazon CloudWatch Logs, AWS KMS, and Terraform,

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

## AWS WAF
- Web ACL is deployed.
- Web ACL is associated with the intended protected resource where applicable.
- WAF rules are present.
- Managed rule groups are configured.
- Rate-based controls are configured.
- IP-based controls are configured where applicable.

## CloudWatch Logs
- WAF log group exists.
- WAF logging is enabled.
- Log retention is configured.
- WAF log events are being delivered.

## AWS KMS
- Customer-managed KMS key exists.
- Key rotation is enabled.
- KMS alias is configured.
- Key policy is attached.
- WAF logging uses the customer-managed key.

## Security Controls
The deployment implements the following enterprise security controls.
Application Security
- AWS WAFv2 application-layer protection.
- Managed AWS rule groups.
- Rate-based request controls.
- IP-based access controls.
- Explicit WAF rule actions.
- Continuous inspection of application traffic.

## Logging and Monitoring
- WAF logging enabled.
- CloudWatch Log Group configured for WAF events.
- Defined log retention period.
- Centralized security-event visibility.
- Logs available for security investigation and operational monitoring.

## Encryption
- Customer-managed AWS KMS key.
- Automatic KMS key rotation.
- WAF logs encrypted at rest.
- Dedicated KMS alias.
- Restrictive KMS key policy.

## Identity and Access Management
- Least-privilege service permissions.
- Service-specific principals.
- Restrictive CloudWatch Logs resource policy.
- Restrictive KMS key policy.
- No hard-coded credentials.
- Explicit service conditions.

## Zero Trust
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
