# ADR-011 – Enterprise Container & Kubernetes Security

## Status

Accepted

## Date

November 2026

## Context

Containerized applications and Kubernetes environments introduce security challenges across the container image lifecycle, orchestration platform, workload identity, admission control, runtime behavior, and network communication.

Organizations operating Amazon EKS need consistent security controls that can be deployed and maintained through infrastructure as code. These controls should reduce the risk of vulnerable container images, unauthorized workload deployments, excessive permissions, and unrestricted communication between workloads.

The Zero Trust Reference Architecture requires a reusable approach to container and Kubernetes security that integrates AWS security capabilities with Kubernetes-native controls.

The architecture must also remain modular and avoid unnecessary dependencies on infrastructure that may already exist in an enterprise environment.

For this reason, the implementation is designed to secure an existing Amazon EKS cluster rather than provision a new cluster.

## Decision

Adopt a modular Terraform-based container and Kubernetes security architecture that integrates AWS security services with Kubernetes-native security controls.

The implementation will use the following architectural decisions:

### 1. Existing EKS Cluster Integration

The module will retrieve and configure security controls for an existing Amazon EKS cluster.

Terraform will use the AWS provider to retrieve cluster information and the Kubernetes and Helm providers to manage Kubernetes resources.

EKS cluster provisioning, VPC creation, and underlying cluster infrastructure are outside the scope of this module.

### 2. Container Image Scanning

Use Amazon ECR enhanced registry scanning to support vulnerability identification across container images.

The implementation will support:

- Enhanced scanning.
- Configurable repository filtering.
- Continuous scanning or scan-on-push configuration.

Because ECR registry scanning configuration is account-level, enabling it requires consideration of its impact on other repositories in the account.

### 3. Kubernetes Admission Control

Adopt Kyverno as the Kubernetes admission control and policy management solution.

Kyverno will be installed through the Terraform Helm provider using version-controlled chart versions.

The implementation will deploy:

- Kyverno admission controller.
- Kyverno policy chart.
- Configurable Pod Security Standard profile.
- Configurable validation failure action.

The default validation action will be `Audit`. This provides visibility into policy violations before organizations introduce enforcement that could affect existing workloads.

### 4. Pod Security Admission

Use native Kubernetes Pod Security Admission labels to establish security requirements for the protected workload namespace.

The namespace will support configurable enforcement levels and separate audit and warning levels.

The default enforcement level will be `baseline`, with audit and warning labels configured to `restricted`.

### 5. Network Segmentation

Use Kubernetes NetworkPolicies to restrict workload communication.

The architecture will implement:

- Default-deny ingress.
- Default-deny egress.
- Explicit DNS egress allowance.

This establishes a restrictive network posture while permitting the DNS communication required by workloads.

NetworkPolicy enforcement depends on the capabilities of the cluster networking implementation.

### 6. Runtime Threat Monitoring

Integrate optional Amazon GuardDuty EKS security features.

The module will support:

- EKS audit log monitoring.
- EKS runtime monitoring.

These features will use an existing GuardDuty detector rather than provisioning a separate detector as part of this module.

### 7. Workload Identity

Support optional IAM Roles for Service Accounts (IRSA).

The implementation will establish an OIDC trust relationship scoped to the configured Kubernetes namespace and service account.

The optional workload IAM role will receive the Amazon ECR read-only managed policy.

This provides a mechanism for workloads to access AWS services without embedding long-lived AWS credentials in container images or application configuration.

### 8. Reusable Terraform Architecture

Maintain a reusable module and a separate deployment example.

The module will contain the AWS and Kubernetes security resources, variables, outputs, and provider requirements.

The deployment example will configure the providers, retrieve the existing EKS cluster, and supply values to the module.

## Decision Drivers

The following considerations influenced the architectural decision:

- **Zero Trust alignment:** Workloads should not receive implicit trust based solely on their network location or deployment status.
- **Least privilege:** Workload identities and permissions should be restricted to their required scope.
- **Defense in depth:** Security must be applied across image scanning, admission control, workload configuration, network communication, and runtime monitoring.
- **Infrastructure as code:** Security controls should be reproducible, reviewable, and version-controlled.
- **Modularity:** Organizations should be able to enable or disable optional capabilities according to their environment.
- **Existing infrastructure compatibility:** The module should integrate with existing EKS environments without requiring cluster recreation.
- **Operational safety:** Policy enforcement should be introduced in a controlled manner to reduce disruption to existing workloads.
- **Maintainability:** Terraform modules and deployment examples should follow the repository's established architecture.

## Alternatives Considered

### Alternative 1: Provision a New EKS Cluster Within the Module

This approach would create an EKS cluster and configure container security controls within the same Terraform module.

**Advantages:**

- Provides a complete cluster and security deployment.
- Allows infrastructure and security configuration to be managed together.

**Disadvantages:**

- Introduces unnecessary infrastructure provisioning.
- Increases module complexity and operational responsibility.
- Reduces flexibility when integrating with existing enterprise clusters.
- Creates additional dependencies on VPC, networking, cluster lifecycle, and node configuration.

**Decision:** Rejected.

The module will secure an existing EKS cluster. Cluster provisioning remains a separate infrastructure responsibility.

### Alternative 2: Use Native Kubernetes Policies Without Kyverno

This approach would rely exclusively on built-in Kubernetes security capabilities.

**Advantages:**

- Reduces dependency on an additional admission controller.
- Uses native Kubernetes functionality.
- Provides basic workload security enforcement.

**Disadvantages:**

- Provides less flexibility for complex admission policies.
- Requires additional mechanisms for broader policy management.
- Does not provide the same policy management capabilities as a dedicated policy engine.

**Decision:** Rejected as the exclusive approach.

Native Pod Security Admission and NetworkPolicies will remain part of the architecture, while Kyverno will provide additional admission control and policy management.

### Alternative 3: Use a Different Kubernetes Policy Engine

OPA Gatekeeper was considered as an alternative admission control solution.

**Advantages:**

- Provides policy-as-code capabilities.
- Supports centralized policy management.
- Can enforce organizational Kubernetes governance requirements.

**Disadvantages:**

- Introduces a different policy language and operational model.
- Would require a separate implementation and validation approach.
- Would increase the number of supported policy-engine configurations.

**Decision:** Not selected for this implementation.

Kyverno was selected to provide the initial admission control and policy management capability. The architecture can evaluate alternative policy engines in future enhancements.

### Alternative 4: Use Static Image Scanning Only

This approach would scan images during the build or publication process without integrating registry-level enhanced scanning.

**Advantages:**

- Can identify vulnerabilities before deployment.
- Can be integrated into CI/CD pipelines.
- May reduce the need for additional runtime registry configuration.

**Disadvantages:**

- Does not provide the same continuous registry-level scanning capability.
- May not identify newly disclosed vulnerabilities in previously scanned images without additional scanning activity.
- Provides less centralized visibility into registry scanning configuration.

**Decision:** Rejected as the exclusive approach.

Amazon ECR enhanced scanning will be supported, while CI/CD image scanning can remain an additional defense-in-depth capability.

## Architectural Consequences

### Positive Consequences

1. Establishes a reusable Terraform module for enterprise container and Kubernetes security.
2. Supports existing Amazon EKS environments without provisioning new clusters.
3. Provides configurable container image scanning through Amazon ECR.
4. Introduces Kyverno admission control and policy management.
5. Establishes Pod Security Admission controls at the namespace level.
6. Reduces unnecessary workload communication through default-deny NetworkPolicies.
7. Supports optional GuardDuty EKS audit and runtime monitoring.
8. Provides optional workload identity through IRSA.
9. Supports centralized configuration through Terraform variables and outputs.
10. Establishes a foundation for extending container security controls across enterprise environments.

### Trade-offs

- The deployment requires access to an existing EKS cluster.
- Kubernetes and Helm resources require appropriate cluster connectivity and authorization.
- Kyverno introduces an additional component that must be maintained and monitored.
- NetworkPolicy enforcement depends on the cluster's CNI implementation.
- ECR registry scanning configuration can affect repositories beyond the immediate workload.
- Moving Kyverno policies from `Audit` to `Enforce` requires workload compatibility testing.
- GuardDuty monitoring capabilities require an existing detector and appropriate service configuration.

## Security Considerations

### Container Image Security

Enhanced ECR scanning helps identify vulnerabilities in container images.

Organizations should establish remediation procedures for vulnerable images and ensure that image updates are incorporated into their deployment pipelines.

### Kubernetes Admission Control

Kyverno provides admission policies to evaluate workload configurations before resources are admitted into the cluster.

The initial `Audit` configuration reduces the risk of disrupting existing workloads while policy violations are reviewed.

### Pod Security

Pod Security Admission labels establish namespace-level security requirements.

The configured enforcement, audit, and warning levels should be reviewed against the organization's workload requirements.

### Network Security

Default-deny ingress and egress policies reduce unnecessary network access.

Explicit DNS egress is required for name resolution. Additional communication requirements should be introduced through narrowly scoped policies rather than broad network permissions.

### Workload Identity

IRSA provides workload-specific AWS identity through OIDC federation.

The IAM trust relationship is scoped to the configured namespace and service account. Permissions should be expanded only when justified by the workload's operational requirements.

### Runtime Monitoring

GuardDuty EKS audit and runtime monitoring provide additional visibility into Kubernetes activity and workload threats.

Organizations should establish processes for reviewing findings and integrating relevant alerts into their security operations workflows.

## Compliance Alignment

The architecture supports security objectives commonly associated with the following frameworks and guidance:

| Framework / Guidance | Relevant Security Objective |
|---|---|
| NIST SP 800-207 | Zero Trust architecture and continuous verification |
| NIST SP 800-190 | Application container security |
| NIST Cybersecurity Framework | Identify, Protect, Detect, Respond, and Recover |
| CIS Kubernetes Benchmark | Kubernetes configuration and workload hardening |
| CIS AWS Foundations Benchmark | AWS account and service security configuration |
| SOC 2 | Logical access, monitoring, and security controls |
| ISO/IEC 27001 | Information security risk management and access control |

This ADR establishes architectural alignment and does not represent a formal compliance certification or independent control assessment.

## Risks

| Risk | Potential Impact | Mitigation |
|---|---|---|
| No existing EKS cluster | Deployment cannot proceed | Require an existing compatible cluster before deployment |
| Incompatible CNI implementation | NetworkPolicies may not be enforced | Verify CNI NetworkPolicy support |
| Overly restrictive Kyverno policies | Legitimate workloads may be blocked | Begin with Audit and review violations |
| ECR registry-level impact | Existing repositories may be affected | Review account-wide scanning configuration before enabling |
| Incorrect GuardDuty configuration | Monitoring features may fail to enable | Validate detector and feature prerequisites |
| Incorrect IRSA trust configuration | Workloads may fail to assume IAM roles | Restrict and verify OIDC trust conditions |
| Kubernetes API access failure | Terraform cannot manage cluster resources | Verify AWS authentication and EKS access permissions |
| Policy version incompatibility | Admission policies may not behave as expected | Maintain tested chart versions and review release compatibility |

## Future Enhancements

Potential enhancements include:

1. Integration with CI/CD pipelines for container image security gates.
2. Automated remediation workflows for vulnerable container images.
3. Centralized security finding integration through AWS Security Hub.
4. Additional Kyverno policies for workload hardening and governance.
5. Integration with OPA Gatekeeper as an alternative policy-engine implementation.
6. Additional Kubernetes RBAC policies and namespace-level access controls.
7. More granular NetworkPolicies for application-specific communication requirements.
8. Additional runtime detection and automated response capabilities.
9. Integration with enterprise SIEM platforms.
10. Support for broader multi-cluster security governance.

These items are potential future enhancements and are not represented as completed capabilities of the current module.

## Conclusion

The selected architecture establishes a reusable, Terraform-based approach to enterprise container and Kubernetes security.

By combining Amazon ECR enhanced scanning, Amazon GuardDuty monitoring, Kyverno admission control, Kubernetes Pod Security Admission, NetworkPolicies, and optional IRSA integration, the implementation provides multiple layers of protection for containerized workloads.

The decision to secure existing EKS clusters rather than provision new clusters keeps the module focused, reusable, and compatible with established enterprise infrastructure.

This architecture advances the Zero Trust Reference Architecture by strengthening workload identity, reducing implicit trust, enforcing security policies, restricting network communication, and supporting continuous threat monitoring.