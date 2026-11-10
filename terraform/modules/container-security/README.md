# Enterprise Container & Kubernetes Security Module

## Overview

The Enterprise Container & Kubernetes Security module implements reusable security controls for existing Amazon EKS environments.

The module supports container image vulnerability scanning, Kubernetes admission control, workload security, runtime monitoring, network segmentation, and workload identity management.

The implementation follows Zero Trust principles and is designed to integrate with an enterprise security monitoring architecture.

## Features

- Existing Amazon EKS cluster integration.
- Amazon ECR enhanced image scanning.
- Amazon GuardDuty EKS audit log monitoring.
- Amazon GuardDuty EKS Runtime Monitoring.
- Kyverno admission control.
- Kubernetes Pod Security policies.
- Kubernetes Pod Security Admission labels.
- Default-deny network policies.
- DNS egress control.
- Optional IAM Roles for Service Accounts.
- Enterprise tagging.
- Reusable Terraform configuration.

## Architecture

```text
                 Existing Amazon EKS Cluster
                            |
             +--------------+--------------+
             |              |              |
        Admission       Workload        Runtime
         Control        Security       Monitoring
             |              |              |
          Kyverno      Pod Security     GuardDuty
             |              |              |
             +--------------+--------------+
                            |
                  Kubernetes Network
                       Policies
                            |
                    Secure Workloads

             AWS Container Security Services
                            |
                 +----------+----------+
                 |                     |
               Amazon ECR          Amazon Inspector
                 |
           Image Scanning
                 |
          Vulnerability Findings

                 Enterprise SIEM
                        ^
                        |
            Centralized Security Events
