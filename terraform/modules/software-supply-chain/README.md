# Enterprise Software Supply Chain Security Module

## Overview

The ZT-012 Software Supply Chain Security module establishes AWS infrastructure controls that support secure software dependency management, controlled build execution, container artifact storage, signing preparation, and build visibility.

The module provides reusable Terraform resources for AWS CodeArtifact, AWS CodeBuild, Amazon ECR, AWS Signer, IAM, and Amazon CloudWatch.

It is designed to integrate with CI/CD security processes rather than replace source-code security platforms or software composition analysis tools.

## Features

- Private package management through AWS CodeArtifact.
- Dedicated CodeBuild service role with scoped permissions.
- Configurable CodeBuild source repository and build specification.
- Amazon ECR repository with image scanning on push.
- Immutable image tags by default.
- ECR lifecycle management for tagged and untagged images.
- AWS Signer OCI signing profile.
- CloudWatch build log retention.
- Consistent resource tagging.
- Reusable variables and outputs.

## Architecture

```text
             Source Code Repository
                     |
                     v
              AWS CodeBuild
                     |
          +----------+-----------+
          |          |           |
          v          v           v
     CodeArtifact   Amazon ECR  CloudWatch
     Dependencies  Artifacts    Build Logs
          |          |
          |          v
          |     Image Scanning
          |          |
          |          v
          |     AWS Signer Profile
          |     (OCI Signing)
          |
          v
     Dependency Retrieval

CI/CD workflow responsibilities:
- Source and dependency security scanning
- SBOM generation (SPDX or CycloneDX)
- Build provenance and attestations
- Artifact signature creation and verification
- Release and deployment approval
