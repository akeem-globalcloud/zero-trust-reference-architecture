output "vpc_id" {

  value = aws_vpc.this.id
}

output "public_subnets" {

  value = aws_subnet.public[*].id
}

output "private_subnets" {

  value = aws_subnet.private[*].id
}

output "database_subnets" {

  value = aws_subnet.database[*].id
}

output "transit_gateway_id" {

  value = aws_ec2_transit_gateway.this.id
}
