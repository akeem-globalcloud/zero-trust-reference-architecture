module "container_security" {
  source = "../../modules/container-security"

  cluster_name       = var.cluster_name
  workload_namespace = var.workload_namespace
  tags               = var.tags

  enable_ecr_enhanced_scanning = var.enable_ecr_enhanced_scanning
  ecr_repository_filter        = var.ecr_repository_filter
  ecr_scan_frequency           = var.ecr_scan_frequency

  enable_guardduty_eks_audit_logs     = var.enable_guardduty_eks_audit_logs
  enable_guardduty_runtime_monitoring = var.enable_guardduty_runtime_monitoring
  guardduty_detector_id               = var.guardduty_detector_id

  enable_kyverno                    = var.enable_kyverno
  kyverno_namespace                 = var.kyverno_namespace
  kyverno_chart_version             = var.kyverno_chart_version
  kyverno_policies_chart_version    = var.kyverno_policies_chart_version
  kyverno_policy_profile            = var.kyverno_policy_profile
  kyverno_validation_failure_action = var.kyverno_validation_failure_action

  enable_pod_security_admission = var.enable_pod_security_admission
  pod_security_enforce_level    = var.pod_security_enforce_level

  enable_network_policies = var.enable_network_policies

  create_workload_iam_role = var.create_workload_iam_role
  oidc_provider_arn        = var.oidc_provider_arn
  workload_service_account = var.workload_service_account
}
