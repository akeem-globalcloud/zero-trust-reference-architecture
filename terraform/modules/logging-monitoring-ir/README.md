# Detection, Monitoring & Incident Response

## Overview

The **Detection, Monitoring & Incident Response** module provides centralized logging, continuous security monitoring, vulnerability assessment, event correlation, and incident response capabilities for the Zero Trust Reference Architecture.

This module leverages native AWS security services to improve visibility, detect threats in near real time, support regulatory compliance, and accelerate security investigations across enterprise cloud environments.

The implementation follows Zero Trust principles by continuously monitoring identities, workloads, network activity, configuration changes, and security events while providing actionable insights through centralized dashboards and security findings.

---

# Objectives

- Centralize security logging
- Continuously monitor cloud infrastructure
- Detect security threats automatically
- Assess workload vulnerabilities
- Improve operational visibility
- Enable rapid incident response
- Support enterprise compliance requirements

---

# Features

## Story 4.0 (v0.4.0)

### AWS CloudTrail

- Multi-region trails
- Management event logging
- Data event logging
- Global service events
- Centralized log storage

---

### Amazon CloudWatch

- Log Groups
- Log Retention
- CloudWatch Metrics
- CloudWatch Alarms
- CloudWatch Dashboards

---

### Amazon SNS

- Security notifications
- Alarm subscriptions
- Email integration

---

### AWS Config

- Resource inventory
- Configuration history
- Compliance monitoring
- Drift detection

---

### AWS Security Hub

- Centralized findings
- Security standards
- Compliance aggregation
- Cross-service visibility

---

# Story 4.1 (v0.4.1)

### Amazon Inspector

Continuous vulnerability management for:

- Amazon EC2
- Amazon ECR
- AWS Lambda

Features include:

- Continuous vulnerability scanning
- CVE identification
- CVSS scoring
- Security Hub integration
- Organization support

---

### CloudWatch Metric Filters

Security metric filters for:

- Root account usage
- Unauthorized API calls
- IAM policy changes
- Console login failures
- Security Group modifications
- Network ACL changes
- CloudTrail changes
- KMS deletion attempts

---

### Amazon EventBridge

Event routing for:

- Inspector findings
- Security Hub findings
- GuardDuty findings
- Config violations
- CloudTrail events

---

### Organization CloudTrail

- Organization-wide logging
- Centralized auditing
- Multi-account visibility
- Governance support

---

### CloudTrail Log File Validation

- Integrity verification
- Tamper detection
- Cryptographic validation

---

### Enhanced Operational Dashboards

Operational KPIs including:

- Vulnerability findings
- Security alarms
- Authentication failures
- Root account activity
- Compliance status
- CloudTrail health
- EventBridge activity

---

### Incident Response

Operational guidance covering:

- Detection
- Triage
- Containment
- Investigation
- Recovery
- Lessons Learned

---

# Architecture

```
                        +------------------------+
                        |     AWS CloudTrail     |
                        +-----------+------------+
                                    |
                                    v
                         +-----------------------+
                         |    CloudWatch Logs    |
                         +-----------+-----------+
                                     |
          +--------------------------+--------------------------+
          |                          |                          |
          v                          v                          v
 +----------------+        +------------------+      +------------------+
 | CloudWatch     |        | AWS Config       |      | Amazon Inspector |
 | Alarms         |        | Compliance       |      | Vulnerability     |
 +--------+-------+        +---------+--------+      +---------+---------+
          |                          |                         |
          +--------------------------+-------------------------+
                                     |
                                     v
                          +----------------------+
                          | AWS Security Hub     |
                          +----------+-----------+
                                     |
                                     v
                          +----------------------+
                          | Amazon EventBridge   |
                          +----------+-----------+
                                     |
                                     v
                          +----------------------+
                          | Amazon SNS           |
                          +----------+-----------+
                                     |
                                     v
                          +----------------------+
                          | Security Operations  |
                          | Incident Response    |
                          +----------------------+
```

---

# Terraform Resources

This module provisions resources for:

- AWS CloudTrail
- Amazon CloudWatch
- CloudWatch Log Groups
- CloudWatch Alarms
- CloudWatch Dashboards
- CloudWatch Metric Filters
- Amazon SNS
- AWS Config
- AWS Security Hub
- Amazon Inspector
- Amazon EventBridge

---

# Compliance Mapping

| Framework | Control |
|-----------|---------|
| NIST Cybersecurity Framework | DE.CM, DE.AE, RS.AN |
| NIST SP 800-53 Rev. 5 | AU-2, AU-6, AU-12, CA-7, RA-5, SI-4 |
| CIS AWS Foundations Benchmark | Logging & Monitoring Controls |
| ISO/IEC 27001:2022 | A.5, A.8, A.8.16, A.8.23 |
| PCI DSS v4.0 | Requirements 10 & 11 |
| HIPAA Security Rule | Audit Controls (§164.312(b)) |

---

# Prerequisites

- Terraform 1.6+
- AWS Provider 5.x+
- AWS Organizations (optional)
- AWS Security Hub
- Appropriate IAM permissions

---

# Deployment

```bash
terraform init

terraform fmt

terraform validate

terraform plan

terraform apply
```

---

# Validation

After deployment, verify:

- CloudTrail is recording events.
- CloudWatch Logs receive audit logs.
- CloudWatch Alarms trigger appropriately.
- AWS Config evaluates resources.
- Security Hub aggregates findings.
- Amazon Inspector scans supported resources.
- EventBridge routes security events.
- SNS notifications are delivered.

---

# Future Enhancements

Future releases may include:

- AWS Detective
- Amazon Security Lake
- Automated remediation with AWS Systems Manager
- SOAR integration
- Third-party SIEM integrations
- Machine learning–based anomaly detection

---

# Version History

| Version | Description |
|----------|-------------|
| **v0.4.0** | Initial implementation of centralized logging, monitoring, alerting, compliance monitoring, and Security Hub integration. |
| **v0.4.1** | Enhanced detection and incident response with Amazon Inspector, CloudWatch Metric Filters, EventBridge integration, Organization CloudTrail, Log File Validation, enhanced dashboards, and operational response guidance. |
