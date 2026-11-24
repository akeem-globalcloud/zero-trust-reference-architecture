check "valid_codeartifact_names" {
  assert {
    condition = (
      length(var.codeartifact_domain_name) >= 2 &&
      length(var.codeartifact_domain_name) <= 50
    )
    error_message = "The CodeArtifact domain name must be between 2 and 50 characters."
  }

  assert {
    condition = (
      length(var.codeartifact_repository_name) >= 2 &&
      length(var.codeartifact_repository_name) <= 100
    )
    error_message = "The CodeArtifact repository name must be between 2 and 100 characters."
  }
}

check "valid_github_repository_url" {
  assert {
    condition     = can(regex("^https://github.com/", var.github_repository_url))
    error_message = "github_repository_url must be an HTTPS GitHub repository URL."
  }
}

check "valid_log_retention" {
  assert {
    condition = contains(
      [1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653],
      var.log_retention_days
    )
    error_message = "log_retention_days must be a supported CloudWatch retention value."
  }
}
