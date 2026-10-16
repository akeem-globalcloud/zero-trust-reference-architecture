###############################################################
# ZT-010 Enterprise Web Application Firewall
# AWS WAFv2 Web ACL
###############################################################

resource "aws_wafv2_ip_set" "blocked" {
  count = length(var.blocked_ip_addresses) > 0 ? 1 : 0

  name               = "${local.waf_name}-blocked-ips"
  description        = "Enterprise WAF blocked IP address set."
  scope              = var.scope
  ip_address_version = "IPV4"
  addresses          = var.blocked_ip_addresses

  tags = local.common_tags
}

resource "aws_wafv2_ip_set" "allowed" {
  count = length(var.allowed_ip_addresses) > 0 ? 1 : 0

  name               = "${local.waf_name}-allowed-ips"
  description        = "Enterprise WAF trusted IP address set."
  scope              = var.scope
  ip_address_version = "IPV4"
  addresses          = var.allowed_ip_addresses

  tags = local.common_tags
}

resource "aws_wafv2_web_acl" "this" {
  name        = local.waf_name
  description = "Enterprise Zero Trust Web Application Firewall."
  scope       = var.scope

  dynamic "default_action" {
    for_each = var.default_action == "ALLOW" ? [1] : []

    content {
      allow {}
    }
  }

  dynamic "default_action" {
    for_each = var.default_action == "BLOCK" ? [1] : []

    content {
      block {}
    }
  }

  #############################################################
  # Explicitly Allowed IP Addresses
  #############################################################

  dynamic "rule" {
    for_each = length(var.allowed_ip_addresses) > 0 ? [1] : []

    content {
      name     = "AllowTrustedIPs"
      priority = 1

      action {
        allow {}
      }

      statement {
        ip_set_reference_statement {
          arn = aws_wafv2_ip_set.allowed[0].arn
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "${local.waf_name}-trusted-ips"
        sampled_requests_enabled   = true
      }
    }
  }

  #############################################################
  # Explicitly Blocked IP Addresses
  #############################################################

  dynamic "rule" {
    for_each = length(var.blocked_ip_addresses) > 0 ? [1] : []

    content {
      name     = "BlockThreatIPs"
      priority = 2

      action {
        block {}
      }

      statement {
        ip_set_reference_statement {
          arn = aws_wafv2_ip_set.blocked[0].arn
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "${local.waf_name}-blocked-ips"
        sampled_requests_enabled   = true
      }
    }
  }

  #############################################################
  # AWS Managed Security Rules
  #############################################################

  dynamic "rule" {
    for_each = var.managed_rule_groups

    content {
      name     = replace(rule.value.name, "AWSManagedRules", "")
      priority = rule.value.priority

      override_action {
        none {}
      }

      statement {
        managed_rule_group_statement {
          name        = rule.value.name
          vendor_name = rule.value.vendor
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "${local.waf_name}-${rule.value.priority}"
        sampled_requests_enabled   = true
      }
    }
  }

  #############################################################
  # Rate-Based Protection
  #############################################################

  dynamic "rule" {
    for_each = var.enable_rate_limit ? [1] : []

    content {
      name     = "RateLimitProtection"
      priority = 100

      action {
        block {}
      }

      statement {
        rate_based_statement {
          limit              = var.rate_limit
          aggregate_key_type = "IP"
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "${local.waf_name}-rate-limit"
        sampled_requests_enabled   = true
      }
    }
  }

  #############################################################
  # Web ACL Visibility
  #############################################################

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${local.waf_name}-web-acl"
    sampled_requests_enabled   = true
  }

  tags = local.common_tags
}
