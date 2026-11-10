variable "cluster_name" {
  description = "Name of the existing Amazon EKS cluster."
  type        = string
}

variable "workload_namespace" {
  description = "Kubernetes namespace where workload security controls will be applied."
  type        = string
  default     = "secure-workloads"
}

variable "tags" {
  description = "Enterprise tags applied to supported AWS resources."
  type        = map(string)
  default     = {}
}

variable "enable_ecr_enhanced_scanning" {
  description = "Enable enhanced scanning for the Amazon ECR registry. This is an account-level registry configuration."
  type        = bool
  default     = false
}

variable "ecr_repository_filter" {
  description = "ECR repository wildcard filter for enhanced scanning."
  type        = string
  default     = "*"
}

variable "ecr_scan_frequency" {
  description = "Enhanced ECR scanning frequency."
  type        = string
  default     = "CONTINUOUS_SCAN"

  validation {
    condition = contains(
      ["CONTINUOUS_SCAN", "SCAN_ON_PUSH", "MANUAL"],
      var.ecr_scan_frequency
    )
    error_message = "Use CONTINUOUS_SCAN, SCAN_ON_PUSH, or MANUAL."
  }
}

variable "enable_guardduty_eks_audit_logs" {
  description = "Enable GuardDuty EKS audit log monitoring on an existing GuardDuty detector."
  type        = bool
  default     = false
}

variable "enable_guardduty_runtime_monitoring" {
  description = "Enable GuardDuty EKS Runtime Monitoring on an existing GuardDuty detector."
  type        = bool
  default     = false
}

variable "guardduty_detector_id" {
  description = "Existing GuardDuty detector ID. Required when either GuardDuty feature is enabled."
  type        = string
  default     = ""
}

variable "enable_kyverno" {
  description = "Install Kyverno and its Pod Security policy chart."
  type        = bool
  default     = true
}

variable "kyverno_namespace" {
  description = "Namespace used for the Kyverno installation."
  type        = string
  default     = "kyverno"
}

variable "kyverno_chart_version" {
  description = "Pinned Kyverno Helm chart version."
  type        = string
  default     = "3.5.2"
}

variable "kyverno_policies_chart_version" {
  description = "Pinned Kyverno policies Helm chart version."
  type        = string
  default     = "3.5.2"
}

variable "kyverno_policy_profile" {
  description = "Pod Security profile enforced by the Kyverno policies chart."
  type        = string
  default     = "restricted"

  validation {
    condition     = contains(["baseline", "restricted"], var.kyverno_policy_profile)
    error_message = "The Kyverno policy profile must be baseline or restricted."
  }
}

variable "kyverno_validation_failure_action" {
  description = "Action taken when a Kyverno policy validation fails."
  type        = string
  default     = "Audit"

  validation {
    condition = contains(
      ["Audit", "Enforce"],
      var.kyverno_validation_failure_action
    )
    error_message = "Use Audit or Enforce."
  }
}

variable "enable_pod_security_admission" {
  description = "Apply Kubernetes Pod Security Admission labels to the workload namespace."
  type        = bool
  default     = true
}

variable "pod_security_enforce_level" {
  description = "Pod Security Admission enforcement level."
  type        = string
  default     = "baseline"

  validation {
    condition     = contains(["privileged", "baseline", "restricted"], var.pod_security_enforce_level)
    error_message = "Use privileged, baseline, or restricted."
  }
}

variable "enable_network_policies" {
  description = "Create default-deny and DNS egress Kubernetes NetworkPolicies."
  type        = bool
  default     = true
}

variable "create_workload_iam_role" {
  description = "Create an optional IRSA role for a Kubernetes service account with ECR read-only access."
  type        = bool
  default     = false
}

variable "oidc_provider_arn" {
  description = "Existing IAM OIDC provider ARN associated with the EKS cluster. Required when creating the workload IAM role."
  type        = string
  default     = ""
}

variable "workload_service_account" {
  description = "Kubernetes service account trusted by the optional IRSA role."
  type        = string
  default     = "container-workload"
}
