resource "aws_guardduty_detector_feature" "eks_audit_logs" {
  count = var.enable_guardduty_eks_audit_logs ? 1 : 0

  detector_id = var.guardduty_detector_id
  name        = "EKS_AUDIT_LOGS"
  status      = "ENABLED"
}

resource "aws_guardduty_detector_feature" "eks_runtime_monitoring" {
  count = var.enable_guardduty_runtime_monitoring ? 1 : 0

  detector_id = var.guardduty_detector_id
  name        = "EKS_RUNTIME_MONITORING"
  status      = "ENABLED"

  additional_configuration {
    name   = "EKS_ADDON_MANAGEMENT"
    status = "ENABLED"
  }
}
