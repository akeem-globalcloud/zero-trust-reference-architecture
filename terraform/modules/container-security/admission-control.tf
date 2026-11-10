resource "helm_release" "kyverno" {
  count = var.enable_kyverno ? 1 : 0

  name             = "kyverno"
  repository       = "https://kyverno.github.io/kyverno/"
  chart            = "kyverno"
  version          = var.kyverno_chart_version
  namespace        = var.kyverno_namespace
  create_namespace = true

  wait    = true
  timeout = 600
}

resource "helm_release" "kyverno_policies" {
  count = var.enable_kyverno ? 1 : 0

  name       = "kyverno-policies"
  repository = "https://kyverno.github.io/kyverno/"
  chart      = "kyverno-policies"
  version    = var.kyverno_policies_chart_version
  namespace  = var.kyverno_namespace

  set {
    name  = "policyKind"
    value = "ClusterPolicy"
  }

  set {
    name  = "podSecurityStandard"
    value = var.kyverno_policy_profile
  }

  set {
    name  = "validationFailureAction"
    value = var.kyverno_validation_failure_action
  }

  wait    = true
  timeout = 600

  depends_on = [
    helm_release.kyverno
  ]
}

resource "kubernetes_namespace_v1" "workloads" {
  metadata {
    name   = var.workload_namespace
    labels = local.workload_namespace_labels
  }
}
