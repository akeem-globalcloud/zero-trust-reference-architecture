check "guardduty_detector_required" {
  assert {
    condition = (
      (!var.enable_guardduty_eks_audit_logs &&
      !var.enable_guardduty_runtime_monitoring) ||
      length(trimspace(var.guardduty_detector_id)) > 0
    )

    error_message = "Provide an existing GuardDuty detector ID when enabling EKS audit logs or runtime monitoring."
  }
}

check "irsa_oidc_provider_required" {
  assert {
    condition = (
      !var.create_workload_iam_role ||
      length(trimspace(var.oidc_provider_arn)) > 0
    )

    error_message = "Provide the existing EKS IAM OIDC provider ARN when create_workload_iam_role is enabled."
  }
}

check "ecr_repository_filter_required" {
  assert {
    condition = (
      !var.enable_ecr_enhanced_scanning ||
      length(trimspace(var.ecr_repository_filter)) > 0
    )

    error_message = "An ECR repository filter is required when enhanced scanning is enabled."
  }
}
