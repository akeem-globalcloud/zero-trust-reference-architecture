aws_region = "us-east-1"

workload = {

  name = "enterprise-workload"

  ami_id = "ami-xxxxxxxx"

  instance_type = "t3.medium"

  subnet_id = "subnet-xxxxxxxx"

  vpc_id = "vpc-xxxxxxxx"

  associate_public_ip = false

  root_volume = {

    size = 50

    type = "gp3"

    encrypted = true

  }

  metadata = {

    http_tokens = "required"

  }

  monitoring = {

    detailed_monitoring = true

  }

  inspector = {

    enabled = true

  }

  tags = {

    Environment = "Production"

    Owner = "Cloud Security"

    Project = "Zero Trust"

  }

}
