variable "aws_region" {
  description = "AWS region containing the existing EKS cluster."
  type        = string
}

variable "cluster_name" {
  description = "Name of the existing Amazon EKS cluster."
  type        = string
}

variable "workload_namespace" {
  description = "Namespace where container security controls will be applied."
  type        = string
  default     = "secure-workloads"
}

variable "tags" {
  description = "Enterprise resource tags."
  type        = map(string)
  default     = {}
}

variable "enable_ecr_enhanced_scanning" {
  description = "Enable enhanced scanning for the ECR registry."
  type        = bool
  default     = false
}

variable "ecr_repository_filter" {
  description = "ECR repository wildcard filter."
  type        = string
  default     = "*"
}

variable "ecr_scan_frequency" {
  description = "ECR enhanced scanning frequency."
  type        = string
  default     = "CONTINUOUS_SCAN"
}

variable "enable_guardduty_eks_audit_logs" {
  description = "Enable GuardDuty EKS audit log monitoring."
  type        = bool
  default     = false
}

variable "enable_guardduty_runtime_monitoring" {
  description = "Enable GuardDuty EKS Runtime Monitoring."
  type        = bool
  default     = false
}

variable "guardduty_detector_id" {
  description = "Existing GuardDuty detector ID."
  type        = string
  default     = ""
}

variable "enable_kyverno" {
  description = "Install Kyverno and its security policy chart."
  type        = bool
  default     = true
}

variable "kyverno_namespace" {
  description = "Namespace for Kyverno."
  type        = string
  default     = "kyverno"
}

variable "kyverno_chart_version" {
  description = "Kyverno Helm chart version."
  type        = string
  default     = "3.5.2"
}

variable "kyverno_policies_chart_version" {
  description = "Kyverno policies Helm chart version."
  type        = string
  default     = "3.5.2"
}

variable "kyverno_policy_profile" {
  description = "Kyverno Pod Security profile."
  type        = string
  default     = "restricted"
}

variable "kyverno_validation_failure_action" {
  description = "Kyverno policy validation action."
  type        = string
  default     = "Audit"
}

variable "enable_pod_security_admission" {
  description = "Enable Pod Security Admission labels."
  type        = bool
  default     = true
}

variable "pod_security_enforce_level" {
  description = "Pod Security Admission enforcement level."
  type        = string
  default     = "baseline"
}

variable "enable_network_policies" {
  description = "Enable Kubernetes NetworkPolicies."
  type        = bool
  default     = true
}

variable "create_workload_iam_role" {
  description = "Create an optional IRSA workload role."
  type        = bool
  default     = false
}

variable "oidc_provider_arn" {
  description = "Existing EKS IAM OIDC provider ARN."
  type        = string
  default     = ""
}

variable "workload_service_account" {
  description = "Kubernetes service account for the optional IRSA role."
  type        = string
  default     = "container-workload"
}
