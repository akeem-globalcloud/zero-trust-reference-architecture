output "instance_id" {

  value = aws_instance.this.id

}

output "instance_arn" {

  value = aws_instance.this.arn

}

output "private_ip" {

  value = aws_instance.this.private_ip

}

output "security_group_id" {

  value = aws_security_group.this.id

}

output "iam_role_name" {

  value = aws_iam_role.this.name

}

output "instance_profile" {

  value = aws_iam_instance_profile.this.name

}
