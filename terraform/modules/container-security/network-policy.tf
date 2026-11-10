resource "kubernetes_network_policy_v1" "default_deny" {
  count = var.enable_network_policies ? 1 : 0

  metadata {
    name      = "default-deny-all"
    namespace = kubernetes_namespace_v1.workloads.metadata[0].name
  }

  spec {
    pod_selector {}

    policy_types = [
      "Ingress",
      "Egress"
    ]
  }
}

resource "kubernetes_network_policy_v1" "allow_dns" {
  count = var.enable_network_policies ? 1 : 0

  metadata {
    name      = "allow-dns-egress"
    namespace = kubernetes_namespace_v1.workloads.metadata[0].name
  }

  spec {
    pod_selector {}

    egress {
      to {
        namespace_selector {
          match_labels = {
            "kubernetes.io/metadata.name" = "kube-system"
          }
        }

        pod_selector {
          match_labels = {
            "k8s-app" = "kube-dns"
          }
        }
      }

      ports {
        port     = "53"
        protocol = "UDP"
      }

      ports {
        port     = "53"
        protocol = "TCP"
      }
    }

    policy_types = [
      "Egress"
    ]
  }

  depends_on = [
    kubernetes_network_policy_v1.default_deny
  ]
}
