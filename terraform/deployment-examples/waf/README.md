# Enterprise Web Application Firewall Deployment

## Overview

This deployment demonstrates how to provision the Enterprise Web Application Firewall (WAF) solution within the Zero Trust Reference Architecture using the reusable Terraform WAF module.

The deployment provides centralized web application protection using AWS WAFv2. The Web ACL is designed to protect enterprise web applications from common web-based threats through managed rule groups, rate-based protection, IP address controls, and centralized logging.

WAF logging is integrated with Amazon CloudWatch Logs and protected using a customer-managed AWS Key Management Service (KMS) key with automatic key rotation enabled.

The deployment is intended to serve as a production-ready reference implementation that can be adapted for enterprise environments while maintaining consistent security controls, Infrastructure as Code (IaC) practices, centralized monitoring, and Zero Trust principles.

---

## Deployment Structure
deployment-examples/
└── waf/
    ├── provider.tf
    ├── versions.tf
    ├── variables.tf
    ├── terraform.tfvars
    ├── main.tf
    ├── outputs.tf
    └── README.md

The deployment example consumes the reusable WAF module located at:
terraform/
└── modules/
    └── waf/
        ├── versions.tf
        ├── provider.tf
        ├── variables.tf
        ├── locals.tf
        ├── main.tf
        ├── kms.tf
        ├── policy.tf
        ├── outputs.tf
        └── README.md

---

## Prerequisites
Before deploying the solution, ensure the following requirements are met.
- Terraform 1.13 or later
- AWS Provider version 6.x
- AWS CLI configured
- Valid AWS credentials
- Appropriate AWS IAM permissions
- Target AWS Region selected
- An application or supported AWS resource available for WAF association
- Permissions to create:
  - AWS WAFv2 Web ACLs
  - AWS WAFv2 rules
  - AWS KMS keys
  - AWS KMS aliases
  - Amazon CloudWatch Log Groups
  - CloudWatch Logs resource policies
  - WAF logging configurations
  - Required IAM policy resources



## Initialize Terraform.
terraform init

## Format the Terraform configuration.
terraform fmt -recursive

## Validate the configuration.
terraform validate

## Review the execution plan.
terraform plan

## Deploy the infrastructure.
terraform apply

Review the Terraform plan carefully before confirming the deployment.
Resources Created
The deployment provisions the following AWS resources.
Resource	Description
- AWS WAFv2 Web ACL |	Provides centralized web application protection
- AWS WAF Managed Rule Groups |	Protects against common and known web-based threats
- AWS WAF Rate-Based Rule |	Helps mitigate excessive request traffic
- AWS WAF IP Set Rules | Provides configurable IP allow and block controls
- AWS KMS Customer Managed Key |	Encrypts WAF logging data
- AWS KMS Alias |	Provides a friendly identifier for the encryption key
- CloudWatch Log Group |	Stores AWS WAF logs
- CloudWatch Logs Resource Policy |	Allows AWS services to deliver WAF logs
- WAF Logging Configuration |	Enables centralized WAF logging
- KMS Key Policy |	Controls access to the customer-managed encryption key


# Verification
After deployment, verify the following.
Terraform
Check the Terraform state.
terraform state list

# Expected resources should include resources similar to:
- aws_wafv2_web_acl.this
- aws_wafv2_ip_set.blocked
- aws_wafv2_ip_set.allowed
- aws_kms_key.waf_logs
- aws_kms_alias.waf_logs
- aws_kms_key_policy.waf_logs
- aws_cloudwatch_log_group.waf
- aws_cloudwatch_log_resource_policy.waf
- aws_wafv2_web_acl_logging_configuration.this

The exact resources shown depend on the enabled configuration options.

## AWS Console
Confirm the following resources exist in the configured AWS Region.
AWS WAF
- Web ACL is deployed
- Web ACL scope is correct
- Managed rule groups are configured
- Rate-based protection is enabled when configured
- IP allow and block controls are configured
- Default action is configured correctly

## AWS KMS
- Customer-managed KMS key exists
- Key rotation is enabled
- KMS alias is configured
- Key policy is attached
- Key is associated with WAF logging

## Amazon CloudWatch
- WAF log group exists
- Log retention is configured for at least one year
- Log group encryption is enabled using the customer-managed KMS key
- WAF log delivery is configured
Security Controls

The deployment implements the following enterprise security controls.
## Web Application Protection
- AWS WAFv2 Web ACL
- AWS managed rule groups
- Rate-based request protection
- IP-based access controls
- Configurable default action
- Centralized WAF policy enforcement

## Encryption
- Customer-managed AWS KMS key
- Automatic KMS key rotation
- CloudWatch WAF logs encrypted at rest
- Dedicated KMS alias
- Restricted KMS key usage through key policy conditions

## Identity and Access Management
- Service-specific IAM permissions
- Restricted AWS service principals
- Least-privilege logging permissions
- Controlled KMS key access
- No unrestricted human access to logging resources

## Logging and Monitoring
- Centralized AWS WAF logging
- CloudWatch Logs integration
- Long-term log retention
- Encrypted security logs
- Resource-level logging controls

## Zero Trust
- Continuous inspection of web traffic
- Explicit security policy enforcement
- Layered request controls
- Continuous security monitoring
- Centralized security logging
- Encryption of security telemetry
- Infrastructure as Code
- Repeatable and version-controlled deployments

## Operational Considerations
The WAF deployment should be integrated with the organization's broader security monitoring and incident response processes.
Security teams should periodically review:
- WAF blocked requests
- Allowed request patterns
- Rate-based rule activity
- Managed rule group findings
- IP allow and block lists
- CloudWatch WAF logs
- KMS key usage
- WAF rule effectiveness
- False-positive activity
- Changes to Web ACL configuration

Managed rule groups should be reviewed periodically to ensure that they remain appropriate for the protected applications.
Enterprise Deployment Considerations
For production environments, the WAF module can be extended to support centralized enterprise deployment across multiple applications and AWS accounts.

**Recommended enterprise practices include:**
- Centralized WAF policy management
- AWS Organizations integration
- Standardized Web ACL configurations
- Application-specific rule exclusions
- Centralized security logging
- Security operations integration
- Automated rule updates
- Infrastructure drift detection
- Terraform state protection
- Change management and approval workflows

The reusable module is intended to provide a consistent baseline that can be customized according to application-specific security requirements.
Zero Trust Alignment
The WAF deployment supports the Zero Trust Reference Architecture by enforcing security controls at the application access layer.
The implementation follows the principle of continuously evaluating and controlling web traffic rather than relying solely on network perimeter security.

**Key Zero Trust principles implemented include:**
- Explicit traffic inspection
- Policy-based access control
- Continuous monitoring
- Threat detection
- Least-privilege service permissions
- Encryption of security telemetry
- Centralized security visibility
- Infrastructure as Code
- Repeatable security enforcement

## Cleanup
To remove all deployed resources, run:
terraform destroy

Review the execution plan before confirming resource deletion.
If WAF resources are associated with an application or other AWS service outside this deployment, remove those associations before destroying the infrastructure.
terraform state list

Use the state output to confirm which resources are managed by this deployment before performing cleanup.

## Conclusion
The Enterprise Web Application Firewall deployment provides a reusable and security-focused AWS WAFv2 implementation for the Zero Trust Reference Architecture.
The deployment combines AWS WAFv2 protection, managed security rules, rate-based controls, IP-based controls, encrypted CloudWatch logging, and customer-managed KMS encryption into a repeatable Terraform implementation.
This provides an enterprise-ready foundation for protecting web applications while maintaining centralized visibility, strong encryption, least-privilege access, and consistent Infrastructure as Code practices.
