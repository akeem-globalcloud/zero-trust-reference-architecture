# ZT-011 – Enterprise Container & Kubernetes Security

## Story Information

| Field | Details |
|---|---|
| Story ID | ZT-011 |
| Title | Enterprise Container & Kubernetes Security |
| Epic | Zero-Trust Reference Architecture |
| Priority | High |
| Status | Implementation and validation |
| Capability | Container and Kubernetes Security |
| Infrastructure as Code | Terraform |
| Cloud Platform | Amazon Web Services |
| Primary Service | Amazon Elastic Kubernetes Service (EKS) |

## User Story

**As a Cloud Security and Infrastructure Engineer,** I want to implement enterprise-grade container and Kubernetes security controls using Terraform 
**So that** containerized workloads are protected against vulnerable images, unauthorized deployments, excessive privileges, runtime threats, and unauthorized network communication.

The implementation should provide reusable security controls that integrate AWS security services with Kubernetes-native security capabilities while supporting Zero Trust principles.

## Business Value

Containerized applications introduce security risks across the image supply chain, orchestration platform, workload identity, runtime environment, and network communication paths.

This story establishes a reusable security foundation for containerized workloads by introducing:

- Container image vulnerability scanning.
- Kubernetes admission control and policy enforcement.
- Pod Security Admission standards.
- Default-deny network segmentation.
- Optional runtime threat monitoring through Amazon GuardDuty.
- Optional workload identity integration through IAM Roles for Service Accounts.
- Centralized and reusable Terraform configuration.

These controls help organizations reduce container-related security exposure, improve workload governance, and establish consistent security practices across Kubernetes environments.

## AWS Services and Technologies

| Service / Technology | Purpose |
|---|---|
| Amazon EKS | Existing managed Kubernetes platform targeted by the security controls |
| Amazon ECR | Container image registry and enhanced image scanning |
| Amazon GuardDuty | EKS audit log monitoring and runtime threat detection |
| AWS IAM | Workload identity and permission management |
| AWS Security Hub | Potential central destination for security findings |
| Amazon Inspector | Container image and workload vulnerability management capability |
| Amazon CloudWatch | AWS monitoring and operational visibility |
| AWS CloudTrail | AWS API activity and audit visibility |
| Kubernetes RBAC | Role-based access control within Kubernetes |
| Kubernetes Pod Security Admission | Namespace-level pod security enforcement |
| Kyverno | Kubernetes admission control and policy management |
| Kubernetes NetworkPolicy | Workload network segmentation |
| Terraform AWS Provider | AWS resource management |
| Terraform Kubernetes Provider | Kubernetes resource management |
| Terraform Helm Provider | Kyverno Helm deployment |

The Terraform implementation in this story directly configures the resources described in the module and deployment example. Services listed as broader architecture integrations are not represented as deployed resources unless explicitly implemented in the module.

## Objectives

The primary objectives of this story are:

1. Secure an existing Amazon EKS cluster through reusable Terraform configuration.
2. Support enhanced container image scanning through Amazon ECR.
3. Enable optional Amazon GuardDuty EKS audit log monitoring.
4. Enable optional GuardDuty EKS runtime monitoring.
5. Deploy Kyverno for Kubernetes admission control and policy management.
6. Apply Kubernetes Pod Security Admission labels to the protected workload namespace.
7. Establish default-deny ingress and egress network policies.
8. Permit the DNS communication required by workloads.
9. Support optional workload identity through IAM Roles for Service Accounts.
10. Provide configurable variables for reusable enterprise deployments.
11. Validate Terraform formatting, configuration, and security posture before deployment.

## Project Structure

The implementation follows the repository's reusable module and deployment-example architecture.

```text
terraform/
├── modules/
│   └── container-security/
│       ├── versions.tf
│       ├── variables.tf
│       ├── locals.tf
│       ├── main.tf
│       ├── iam.tf
│       ├── eks.tf
│       ├── admission-control.tf
│       ├── image-scanning.tf
│       ├── network-policy.tf
│       ├── runtime-monitoring.tf
│       ├── outputs.tf
│       └── README.md
│
└── deployment-examples/
    └── container-security/
        ├── versions.tf
        ├── provider.tf
        ├── variables.tf
        ├── main.tf
        ├── terraform.tfvars.example
        ├── outputs.tf
        └── README.md
```

## Terraform Resources

The module uses reusable Terraform resources and data sources to implement the container security controls.

| Resource / Data Source | Purpose |
|---|---|
| `data.aws_eks_cluster` | Retrieves information about the existing EKS cluster |
| `aws_ecr_registry_scanning_configuration` | Configures enhanced ECR registry scanning |
| `aws_guardduty_detector_feature` | Enables optional EKS audit log and runtime monitoring features |
| `helm_release.kyverno` | Installs the Kyverno admission controller |
| `helm_release.kyverno_policies` | Installs Kyverno policy resources |
| `kubernetes_namespace_v1` | Creates the protected workload namespace with security labels |
| `kubernetes_network_policy_v1` | Implements default-deny ingress and egress controls and DNS egress |
| `aws_iam_role` | Creates an optional workload IAM role |
| `aws_iam_policy_document` | Defines the optional OIDC trust relationship |
| `kubernetes_service_account_v1` | Creates the optional Kubernetes service account associated with the IAM role |

The module reads the existing EKS cluster. It does not create an EKS cluster or provision its underlying VPC and networking infrastructure.

## Security Controls

### 1. Container Image Security

Amazon ECR enhanced scanning provides vulnerability scanning for container images.

The module supports:

- Enhanced scanning configuration.
- Configurable repository filtering.
- Continuous scanning or scan-on-push configuration.

### 2. Kubernetes Admission Control

Kyverno provides policy-based admission control for Kubernetes workloads.

The implementation:

- Deploys Kyverno through Helm.
- Deploys the Kyverno policies chart.
- Supports a configurable Pod Security Standard profile.
- Supports `Audit` and `Enforce` validation actions.

The default validation action is `Audit`, allowing policy violations to be observed before enforcement is introduced.

### 3. Pod Security Admission

The module applies Pod Security Admission labels to the protected workload namespace.

The configured labels support:

- Enforcement level selection.
- Restricted audit and warning levels.
- Version labels for policy consistency.
- Terraform-managed namespace identification.

The default enforcement level is `baseline`.

### 4. Network Segmentation

Kubernetes NetworkPolicies provide workload network restrictions.

The implementation includes:

- Default-deny ingress.
- Default-deny egress.
- DNS egress allowance to the configured cluster DNS pods.

NetworkPolicy enforcement depends on support from the cluster's networking implementation.

### 5. Runtime Threat Monitoring

The module supports optional GuardDuty EKS security features:

- EKS audit log monitoring.
- EKS runtime monitoring.

These features use an existing GuardDuty detector.

### 6. Workload Identity

Optional IAM Roles for Service Accounts provide workload-level AWS identity.

The implementation:

- Creates an IAM role.
- Establishes an OIDC trust relationship.
- Restricts the trust relationship to the configured namespace and service account.
- Associates the IAM role with the Kubernetes service account.

The optional role receives the Amazon ECR read-only managed policy.

## Zero Trust Alignment

This story supports the Zero Trust Reference Architecture through the following principles:

| Zero Trust Principle | Implementation |
|---|---|
| Verify explicitly | Admission policies and workload identity controls |
| Least privilege | Optional namespace- and service-account-scoped IAM trust |
| Assume breach | Default-deny network policies and runtime monitoring |
| Secure workloads | ECR image scanning and Kubernetes policy enforcement |
| Continuous monitoring | Optional GuardDuty EKS audit and runtime monitoring |
| Minimize implicit trust | Restricted workload communication and namespace security controls |

The implementation provides reusable controls that can be integrated into a broader enterprise Zero Trust architecture.

## Outputs

The module exposes outputs for:

- Existing EKS cluster name.
- EKS cluster ARN.
- EKS cluster endpoint.
- Protected workload namespace.
- Kyverno release name.
- Kyverno policies release name.
- ECR registry scanning configuration identifier.
- GuardDuty EKS audit monitoring status.
- GuardDuty runtime monitoring status.
- Optional workload IAM role ARN.
- NetworkPolicy enablement status.

Sensitive cluster information is marked appropriately in the module outputs.

## Acceptance Criteria

| ID | Acceptance Criteria |
|---|---|
| AC-01 | Terraform module and deployment example are organized under the established repository structure |
| AC-02 | Terraform supports the required AWS, Kubernetes, and Helm providers |
| AC-03 | The module retrieves an existing EKS cluster without creating a new cluster |
| AC-04 | ECR enhanced scanning can be configured through module variables |
| AC-05 | GuardDuty EKS audit monitoring can be enabled optionally |
| AC-06 | GuardDuty EKS runtime monitoring can be enabled optionally |
| AC-07 | Kyverno and its policy chart can be installed through Helm |
| AC-08 | Pod Security Admission labels are applied to the workload namespace |
| AC-09 | Default-deny ingress and egress NetworkPolicies are supported |
| AC-10 | DNS egress is permitted by the configured NetworkPolicy |
| AC-11 | Optional IRSA integration creates a scoped IAM role and Kubernetes service account |
| AC-12 | Module variables and outputs support reusable configuration |
| AC-13 | Terraform formatting and validation are completed |
| AC-14 | Checkov and Trivy security scans are executed against the module and deployment example |
| AC-15 | Documentation explains prerequisites, configuration, deployment, verification, and operational considerations |

## Important Architectural Considerations

1. **Existing cluster requirement:** The module is designed to secure an existing EKS cluster. EKS cluster provisioning is outside this story's scope.
2. **Account-level ECR configuration:** ECR registry scanning configuration applies at the registry level and may affect repositories beyond the immediate workload.
3. **GuardDuty prerequisites:** GuardDuty features require an existing detector and appropriate service configuration.
4. **Policy enforcement:** Kyverno validation defaults to `Audit`. Organizations should review policy results before switching to `Enforce`.
5. **Network policy compatibility:** NetworkPolicies require a compatible CNI implementation for enforcement.
6. **IRSA configuration:** IRSA requires an existing EKS OIDC provider and appropriate IAM trust configuration.
7. **Provider connectivity:** Kubernetes and Helm resources require access to the target EKS API endpoint during planning and deployment.
8. **Validation scope:** Terraform formatting, validation, and static security scans do not replace deployment testing or runtime verification.

## Documentation Standard

The implementation includes:

- Reusable Terraform module documentation.
- Deployment example documentation.
- Architecture decision record ADR-011.
- This implementation story.

The deployment example documents how to configure the module for an existing EKS environment. The repository validation workflow focuses on static Terraform validation and security scanning and does not require provisioning an EKS cluster.
