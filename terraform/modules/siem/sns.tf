###############################################################
# SNS Topic
###############################################################

resource "aws_sns_topic" "siem" {

  count = var.siem.sns.enabled ? 1 : 0

  name = var.siem.sns.topic_name

  kms_master_key_id = aws_kms_key.siem.arn

  tags = local.common_tags

}

###############################################################
# Email Subscription
###############################################################

resource "aws_sns_topic_subscription" "email" {

  count = (
    var.siem.sns.enabled &&
    try(var.siem.sns.email_address, "") != ""
  ) ? 1 : 0

  topic_arn = aws_sns_topic.siem[0].arn

  protocol = "email"

  endpoint = var.siem.sns.email_address

}
