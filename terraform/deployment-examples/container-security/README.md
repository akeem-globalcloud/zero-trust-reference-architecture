# Enterprise Container & Kubernetes Security Deployment

## Overview

This deployment example demonstrates how to implement enterprise container and Kubernetes security controls using reusable Terraform infrastructure-as-code.

The deployment integrates AWS security services with Kubernetes-native controls to strengthen the security posture of containerized workloads running on Amazon Elastic Kubernetes Service (Amazon EKS).

The implementation focuses on securing an existing EKS cluster through image scanning, admission control, workload namespace security, network segmentation, and optional runtime threat monitoring.

The deployment is designed to support Zero Trust principles by enforcing workload security controls, reducing unnecessary communication, validating Kubernetes configurations, and integrating AWS security capabilities.

**Important:** This deployment does not provision an Amazon EKS cluster. It connects to an existing EKS cluster and configures the selected security controls within that environment.

## Architecture

The deployment uses Terraform to configure AWS resources and Kubernetes resources through the AWS, Kubernetes, and Helm providers.

```text
                    AWS Account
                         |
                         |
                  Existing EKS Cluster
                         |
             +-----------+-----------+
             |                       |
       AWS Security Services    Kubernetes Controls
             |                       |
       +-----+------+          +-----+----------------+
       |            |          |                      |
      ECR        GuardDuty   Kyverno              Pod Security
   Image Scan    Monitoring Admission Control     Admission
       |            |          |                      |
       +------------+----------+----------------------+
                         |
                 Workload Namespace
                         |
              +----------+-----------+
              |                      |
        Default-Deny Policy     DNS Egress Rule
              |                      |
              +----------+-----------+
                         |
                 Protected Workloads
                         |
                Optional IRSA Role
                         |
                AWS IAM Permissions
```

## Deployment Structure

```text
container-security/
├── versions.tf
├── provider.tf
├── variables.tf
├── main.tf
├── terraform.tfvars.example
├── outputs.tf
└── README.md
```

The deployment example calls the reusable module located at:

```text
terraform/modules/container-security/
```

## Prerequisites

Before deploying this configuration, the following requirements must be satisfied:

- An existing Amazon EKS cluster.
- AWS CLI installed and configured.
- Terraform version 1.13.0 or later.
- AWS provider version compatible with `~> 6.0`.
- Kubernetes provider version compatible with `~> 2.35`.
- Helm provider version compatible with `~> 2.17`.
- Helm CLI available for chart inspection and operational troubleshooting.
- IAM permissions to read the target EKS cluster and manage the selected AWS security resources.
- Kubernetes permissions to create namespaces, NetworkPolicies, and other configured Kubernetes resources.
- Helm permissions to install Kyverno and its policy chart.
- An existing GuardDuty detector when GuardDuty EKS features are enabled.
- An existing EKS OIDC provider when IRSA is enabled.

The AWS identity used by Terraform must also be authorized to authenticate to the target EKS cluster.

## Deployment Configuration

The `terraform.tfvars.example` file provides an example configuration.

Create a local variables file from the example:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Update the values in `terraform.tfvars` to match the target AWS environment.

Example configuration:

```hcl
aws_region   = "us-east-1"
cluster_name = "REPLACE-WITH-EXISTING-EKS-CLUSTER"

tags = {
  Environment = "Production"
  Owner       = "Cloud Security"
  Project     = "Zero Trust Reference Architecture"
}

enable_ecr_enhanced_scanning = false
ecr_repository_filter        = "*"
ecr_scan_frequency           = "CONTINUOUS_SCAN"

enable_guardduty_eks_audit_logs = false
enable_guardduty_runtime_monitoring = false
guardduty_detector_id = ""

enable_kyverno                 = true
kyverno_namespace              = "kyverno"
kyverno_chart_version          = "3.5.2"
kyverno_policies_chart_version = "3.5.2"
kyverno_policy_profile         = "restricted"
kyverno_validation_failure_action = "Audit"

enable_pod_security_admission = true
pod_security_enforce_level    = "baseline"

enable_network_policies = true

enable_irsa                 = false
oidc_provider_arn           = ""
workload_service_account    = "container-workload"
workload_namespace          = "secure-workloads"
```

### Configuration Considerations

- `cluster_name` must identify an existing EKS cluster.
- ECR enhanced scanning is disabled by default. Enabling it configures registry-level enhanced scanning and can affect other repositories in the AWS account.
- GuardDuty EKS audit logging and runtime monitoring are optional. Enabling either requires a valid GuardDuty detector ID and the relevant GuardDuty capabilities.
- Kyverno is enabled by default. Its chart versions and policy profile can be adjusted through variables.
- The default Kyverno validation action is `Audit`, allowing policy violations to be reported without immediately blocking workloads. `Enforce` can be selected when the organization is ready to block noncompliant resources.
- Pod Security Admission applies the configured enforcement level to the workload namespace. The default enforcement level is `baseline`.
- NetworkPolicies are enabled by default. The configured policies deny ingress and egress by default and permit DNS egress to the configured cluster DNS pods.
- IRSA is optional. When enabled, the configuration requires the EKS OIDC provider ARN and creates a dedicated IAM role and Kubernetes service account.

Do not commit the populated `terraform.tfvars` file or environment-specific credentials to GitHub.

## Deployment Steps

The following steps describe deployment into an environment that already has an EKS cluster.

### 1. Navigate to the deployment directory

```bash
cd terraform/deployment-examples/container-security
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Validate the Terraform configuration

```bash
terraform fmt -check -recursive
terraform validate
```

### 4. Review the deployment plan

After configuring a valid existing EKS cluster and the required AWS and Kubernetes access:

```bash
terraform plan
```

Review the proposed changes before proceeding.

### 5. Apply the configuration

Only after reviewing and approving the plan:

```bash
terraform apply
```

**Deployment limitation:** The plan and apply operations require an accessible EKS cluster and the necessary AWS and Kubernetes permissions. They are not part of the repository's static validation workflow.

## Resources Created

Depending on the enabled configuration options, the module manages the following resources:

| Resource | Purpose |
|---|---|
| ECR registry scanning configuration | Enables enhanced container image scanning |
| GuardDuty detector features | Enables EKS audit logging and runtime monitoring features |
| Kyverno Helm release | Installs the Kyverno admission controller |
| Kyverno policies Helm release | Installs Kubernetes policy controls |
| Kubernetes workload namespace | Creates the namespace for protected workloads |
| Kubernetes NetworkPolicies | Applies default-deny ingress and egress controls and permits DNS egress |
| IAM role | Creates an optional workload IAM role for IRSA |
| Kubernetes service account | Creates an optional service account associated with the IAM role |

The module also reads the existing EKS cluster configuration to obtain cluster information. It does not create or manage the EKS control plane.

## Verification

After deployment, verify the resources and controls.

### Terraform Verification

```bash
terraform state list
terraform output
```

### Kubernetes Verification

Confirm the workload namespace exists:

```bash
kubectl get namespace secure-workloads
```

Inspect namespace security labels:

```bash
kubectl get namespace secure-workloads --show-labels
```

Verify Kyverno deployments:

```bash
kubectl get deployments -n kyverno
```

Verify Kyverno policies:

```bash
kubectl get clusterpolicies
```

Verify NetworkPolicies:

```bash
kubectl get networkpolicies -n secure-workloads
```

Verify the workload service account when IRSA is enabled:

```bash
kubectl get serviceaccounts -n secure-workloads
```

### AWS Verification

Use the AWS Management Console or AWS CLI to verify:

- ECR registry scanning configuration.
- GuardDuty EKS audit logging and runtime monitoring features, when enabled.
- The optional IAM role created for the workload service account.

## Security Controls

### Container Image Security

- Supports Amazon ECR enhanced image scanning.
- Enables continuous or on-push scanning based on configuration.
- Allows repository filtering through Terraform variables.

### Kubernetes Admission Control

- Deploys Kyverno as a Kubernetes admission controller.
- Deploys Kyverno policy resources using a version-controlled Helm chart.
- Supports a configurable Pod Security Standard profile.
- Supports `Audit` and `Enforce` validation actions.

### Pod Security Admission

- Applies Kubernetes Pod Security Admission labels to the workload namespace.
- Supports configurable enforcement levels.
- Configures audit and warning levels to provide additional visibility into workload security violations.

### Network Segmentation

- Creates default-deny ingress and egress NetworkPolicies.
- Allows DNS egress to the configured Kubernetes DNS pods.
- Reduces unnecessary workload-to-workload and workload-to-external communication.

NetworkPolicy enforcement depends on the cluster networking implementation and its support for Kubernetes NetworkPolicies.

### Runtime Threat Monitoring

- Supports GuardDuty EKS audit log monitoring.
- Supports GuardDuty EKS runtime monitoring.
- Uses an existing GuardDuty detector rather than provisioning a separate detector.

### Workload Identity

- Supports optional IAM Roles for Service Accounts.
- Uses an OIDC trust relationship scoped to the configured namespace and service account.
- Avoids requiring long-lived AWS credentials inside container workloads.

## Validation

The configuration supports static validation and security scanning before deployment.

### Terraform Formatting

```bash
terraform fmt -check -recursive
```

### Terraform Validation

```bash
terraform init
terraform validate
```

### Checkov

From the repository root:

```bash
checkov -d terraform/modules/container-security --framework terraform
checkov -d terraform/deployment-examples/container-security --framework terraform
```

### Trivy

From the repository root:

```bash
trivy config terraform/modules/container-security
trivy config terraform/deployment-examples/container-security
```

These checks evaluate Terraform configuration and security configuration. They do not prove that the resources have been successfully deployed or that runtime controls are functioning in a live cluster.

## Important Operational Considerations

1. **Existing EKS cluster:** The deployment requires an existing cluster and does not provision EKS infrastructure.
2. **AWS permissions:** The Terraform execution identity must have the necessary permissions for AWS resource management and EKS authentication.
3. **Kubernetes access:** The execution identity must be authorized to create and manage the configured Kubernetes resources.
4. **ECR registry scope:** ECR registry scanning configuration is account-level. Review the impact on existing repositories before enabling enhanced scanning.
5. **GuardDuty prerequisites:** GuardDuty features require an existing detector and appropriate service configuration.
6. **Kyverno policy enforcement:** Begin with `Audit` where appropriate, review policy reports, and move to `Enforce` after validating workload compatibility.
7. **NetworkPolicy support:** Confirm that the cluster's CNI implementation enforces Kubernetes NetworkPolicies.
8. **IRSA prerequisites:** IRSA requires an existing EKS OIDC provider and correct trust-policy configuration.
9. **Cluster compatibility:** Confirm the target EKS and Kubernetes versions are compatible with the selected Kyverno chart versions.

## Cleanup

In a deployed environment, review the Terraform plan before removing the resources managed by this module:

```bash
terraform plan -destroy
```

If removal is approved:

```bash
terraform destroy
```

Review the impact of removing account-level ECR scanning configuration and Kubernetes admission policies before proceeding. Do not remove resources that are shared with other workloads or managed by another deployment.

