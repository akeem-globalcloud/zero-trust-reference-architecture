###############################################################
# Root Account
###############################################################

data "aws_iam_policy_document" "root" {

  statement {

    sid = "EnableRootPermissions"

    effect = "Allow"

    principals {

      type = "AWS"

      identifiers = [
        "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
      ]

    }

    actions = [
      "kms:*"
    ]

    resources = ["*"]

  }

}

###############################################################
# Administrators
###############################################################

data "aws_iam_policy_document" "administrators" {

  dynamic "statement" {

    for_each = length(var.kms.access.administrators) > 0 ? [1] : []

    content {

      sid = "KeyAdministrators"

      effect = "Allow"

      principals {

        type = "AWS"

        identifiers = tolist(var.kms.access.administrators)

      }

      actions = [

        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:Disable*",
        "kms:Get*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Delete*",
        "kms:TagResource",
        "kms:UntagResource",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion"

      ]

      resources = ["*"]

    }

  }

}

###############################################################
# Users
###############################################################

data "aws_iam_policy_document" "users" {

  dynamic "statement" {

    for_each = length(var.kms.access.users) > 0 ? [1] : []

    content {

      sid = "KeyUsers"

      effect = "Allow"

      principals {

        type = "AWS"

        identifiers = tolist(var.kms.access.users)

      }

      actions = [

        "kms:Encrypt",
        "kms:Decrypt",
        "kms:GenerateDataKey*",
        "kms:ReEncrypt*",
        "kms:DescribeKey"

      ]

      resources = ["*"]

    }

  }

}

###############################################################
# AWS Services
###############################################################

data "aws_iam_policy_document" "services" {

  dynamic "statement" {

    for_each = length(var.kms.access.service_principals) > 0 ? [1] : []

    content {

      sid = "AWSServices"

      effect = "Allow"

      principals {

        type = "Service"

        identifiers = tolist(var.kms.access.service_principals)

      }

      actions = [

        "kms:Encrypt",
        "kms:Decrypt",
        "kms:GenerateDataKey*",
        "kms:DescribeKey",
        "kms:CreateGrant"

      ]

      resources = ["*"]

      condition {

        test = "Bool"

        variable = "kms:GrantIsForAWSResource"

        values = ["true"]

      }

    }

  }

}

###############################################################
# Final Policy
###############################################################

data "aws_iam_policy_document" "merged" {

  source_policy_documents = compact(concat(

    [
      data.aws_iam_policy_document.root.json,
      data.aws_iam_policy_document.administrators.json,
      data.aws_iam_policy_document.users.json,
      data.aws_iam_policy_document.services.json
    ],

    var.kms.additional_policy_documents

  ))

}
