resource "aws_ecr_registry_scanning_configuration" "container_security" {
  count = var.enable_ecr_enhanced_scanning ? 1 : 0

  scan_type = "ENHANCED"

  rule {
    scan_frequency = var.ecr_scan_frequency

    repository_filter {
      filter      = var.ecr_repository_filter
      filter_type = "WILDCARD"
    }
  }
}
