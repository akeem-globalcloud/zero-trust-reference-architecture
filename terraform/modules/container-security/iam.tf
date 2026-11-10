data "aws_iam_policy_document" "workload_assume_role" {
  count = var.create_workload_iam_role ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:sub"

      values = [
        "system:serviceaccount:${var.workload_namespace}:${var.workload_service_account}"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "workload" {
  count = var.create_workload_iam_role ? 1 : 0

  name               = "${local.name_prefix}-workload-role"
  assume_role_policy = data.aws_iam_policy_document.workload_assume_role[0].json

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "ecr_read_only" {
  count = var.create_workload_iam_role ? 1 : 0

  role       = aws_iam_role.workload[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "kubernetes_service_account_v1" "workload" {
  count = var.create_workload_iam_role ? 1 : 0

  metadata {
    name      = var.workload_service_account
    namespace = var.workload_namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.workload[0].arn
    }
  }

  depends_on = [
    kubernetes_namespace_v1.workloads
  ]
}
