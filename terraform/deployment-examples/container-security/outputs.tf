output "eks_cluster_name" {
  description = "Existing EKS cluster name."
  value       = module.container_security.eks_cluster_name
}

output "eks_cluster_arn" {
  description = "Existing EKS cluster ARN."
  value       = module.container_security.eks_cluster_arn
}

output "workload_namespace" {
  description = "Protected Kubernetes workload namespace."
  value       = module.container_security.workload_namespace
}

output "kyverno_release_name" {
  description = "Kyverno Helm release."
  value       = module.container_security.kyverno_release_name
}

output "kyverno_policies_release_name" {
  description = "Kyverno security policies Helm release."
  value       = module.container_security.kyverno_policies_release_name
}

output "ecr_scanning_registry_id" {
  description = "ECR registry ID when enhanced scanning is enabled."
  value       = module.container_security.ecr_scanning_registry_id
}

output "guardduty_eks_audit_logs_enabled" {
  description = "GuardDuty EKS audit log monitoring status."
  value       = module.container_security.guardduty_eks_audit_logs_enabled
}

output "guardduty_runtime_monitoring_enabled" {
  description = "GuardDuty EKS runtime monitoring status."
  value       = module.container_security.guardduty_runtime_monitoring_enabled
}

output "workload_iam_role_arn" {
  description = "Optional workload IRSA role ARN."
  value       = module.container_security.workload_iam_role_arn
}

output "network_policies_enabled" {
  description = "Kubernetes NetworkPolicy deployment status."
  value       = module.container_security.network_policies_enabled
}
