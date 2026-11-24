# CodeBuild execution logs are written to the CloudWatch log group
# declared in codebuild.tf.
#
# CloudTrail is an account-level service and is intentionally not
# created by this module. Integrate this capability with the
# centralized logging and monitoring controls from earlier stories.
#
# SBOM generation, vulnerability assessment, provenance creation,
# and signature verification are performed by the CI/CD workflow.
