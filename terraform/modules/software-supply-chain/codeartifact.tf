resource "aws_codeartifact_domain" "this" {
  domain         = var.codeartifact_domain_name
  encryption_key = aws_kms_key.codeartifact.arn

  tags = local.common_tags
}

resource "aws_codeartifact_repository" "this" {
  repository = var.codeartifact_repository_name
  domain     = aws_codeartifact_domain.this.domain

  dynamic "external_connections" {
    for_each = length(var.codeartifact_external_connections) > 0 ? [1] : []

    content {
      external_connection_name = var.codeartifact_external_connections[0]
    }
  }

  tags = local.common_tags
}
