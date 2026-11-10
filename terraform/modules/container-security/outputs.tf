output "eks_cluster_name" {
  description = "Name of the existing EKS cluster."
  value       = data.aws_eks_cluster.this.name
}

output "eks_cluster_arn" {
  description = "ARN of the existing EKS cluster."
  value       = data.aws_eks_cluster.this.arn
}

output "eks_cluster_endpoint" {
  description = "API endpoint of the existing EKS cluster."
  value       = data.aws_eks_cluster.this.endpoint
  sensitive   = true
}

output "workload_namespace" {
  description = "Kubernetes namespace protected by this module."
  value       = kubernetes_namespace_v1.workloads.metadata[0].name
}

output "kyverno_release_name" {
  description = "Kyverno Helm release name, when enabled."
  value       = var.enable_kyverno ? helm_release.kyverno[0].name : null
}

output "kyverno_policies_release_name" {
  description = "Kyverno policies Helm release name, when enabled."
  value       = var.enable_kyverno ? helm_release.kyverno_policies[0].name : null
}

output "ecr_scanning_registry_id" {
  description = "ECR registry ID when enhanced scanning is enabled."
  value       = var.enable_ecr_enhanced_scanning ? aws_ecr_registry_scanning_configuration.container_security[0].registry_id : null
}

output "guardduty_eks_audit_logs_enabled" {
  description = "Whether GuardDuty EKS audit log monitoring is managed by this module."
  value       = var.enable_guardduty_eks_audit_logs
}

output "guardduty_runtime_monitoring_enabled" {
  description = "Whether GuardDuty EKS Runtime Monitoring is managed by this module."
  value       = var.enable_guardduty_runtime_monitoring
}

output "workload_iam_role_arn" {
  description = "Optional IRSA role ARN for the workload service account."
  value       = var.create_workload_iam_role ? aws_iam_role.workload[0].arn : null
}

output "network_policies_enabled" {
  description = "Whether default-deny and DNS NetworkPolicies are managed by this module."
  value       = var.enable_network_policies
}
