# Enterprise Software Supply Chain Deployment

## Overview

This deployment provisions the AWS infrastructure defined in the ZT-012 Software Supply Chain Security module.

It establishes private package management, a controlled CodeBuild project, an ECR artifact repository, an OCI signing profile, and centralized build logs.

This example does not automatically configure GitHub branch protection, generate SBOMs, execute vulnerability scanners, or verify signed artifacts.

## Architecture

```text
GitHub Repository
       |
       v
   AWS CodeBuild
       |
       +------------------+
       |                  |
       v                  v
  CodeArtifact        Amazon ECR
  Package Access      Artifact Storage
                          |
                          v
                    Image Scanning
                          |
                          v
                    AWS Signer Profile

CodeBuild Logs ------> CloudWatch Logs