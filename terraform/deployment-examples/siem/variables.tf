###############################################################
# AWS Region
###############################################################

variable "aws_region" {

  description = "AWS Region."

  type = string

  default = "us-east-1"

}

###############################################################
# Enterprise SIEM
###############################################################

variable "siem" {

  description = "Enterprise SIEM configuration."

  type = any

}
