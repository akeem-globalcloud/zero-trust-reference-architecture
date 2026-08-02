resource "aws_security_group" "this" {

  name = "${var.workload.name}-sg"

  description = "Enterprise workload protection security group"

  vpc_id = var.workload.vpc_id

  tags = local.common_tags

}

resource "aws_instance" "this" {

  ami           = var.workload.ami_id
  instance_type = var.workload.instance_type

  subnet_id = var.workload.subnet_id

  private_ip = try(var.workload.private_ip, null)

  associate_public_ip_address = var.workload.associate_public_ip

  iam_instance_profile = aws_iam_instance_profile.this.name

  monitoring = var.workload.monitoring.detailed_monitoring

  ebs_optimized = true

  vpc_security_group_ids = [
    aws_security_group.this.id
  ]

  metadata_options {

    http_endpoint               = var.workload.metadata.http_endpoint
    http_tokens                 = var.workload.metadata.http_tokens
    http_put_response_hop_limit = var.workload.metadata.http_put_response_hop_limit
    instance_metadata_tags      = var.workload.metadata.instance_metadata_tags

  }

  root_block_device {

    volume_size = local.root_volume.size

    volume_type = local.root_volume.type

    encrypted = local.root_volume.encrypted

    kms_key_id = try(local.root_volume.kms_key_id, null)

    delete_on_termination = true

  }

  tags = merge(

    local.common_tags,

    {
      Name = local.instance_name
    }

  )

}
