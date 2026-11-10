locals {
  name_prefix = "zt011-${var.cluster_name}"

  common_tags = merge(
    {
      Project    = "Zero-Trust-Reference-Architecture"
      Story      = "ZT-011"
      Capability = "Container-and-Kubernetes-Security"
      ManagedBy  = "Terraform"
    },
    var.tags
  )

  workload_namespace_labels = var.enable_pod_security_admission ? {
    "pod-security.kubernetes.io/enforce"         = var.pod_security_enforce_level
    "pod-security.kubernetes.io/enforce-version" = "latest"
    "pod-security.kubernetes.io/audit"           = "restricted"
    "pod-security.kubernetes.io/audit-version"   = "latest"
    "pod-security.kubernetes.io/warn"            = "restricted"
    "pod-security.kubernetes.io/warn-version"    = "latest"
    "app.kubernetes.io/managed-by"               = "Terraform"
    } : {
    "app.kubernetes.io/managed-by" = "Terraform"
  }
}
