# Logging & Monitoring Deployment Example

## Overview

This deployment example demonstrates how to deploy the Enterprise Logging & Monitoring Terraform module.

## Features

- AWS CloudTrail
- Amazon CloudWatch Logs
- CloudWatch Dashboard
- CloudWatch Alarm
- AWS Config
- AWS Security Hub
- Amazon SNS Notifications

## Usage

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

## Module Source

```hcl
module "logging" {
  source = "../../modules/logging"
}
```

## Expected Outputs

- CloudTrail Name
- CloudWatch Log Group
- Dashboard Name
- SNS Topic ARN
