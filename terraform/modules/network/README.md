# Enterprise Network Module

## Overview

The Enterprise Network Module provisions a production-ready AWS networking foundation designed for Zero Trust environments.

The module creates a highly available Virtual Private Cloud (VPC) architecture with public, private, and database subnets distributed across multiple Availability Zones. It is intended to serve as the networking foundation for secure cloud workloads and enterprise landing zones.

---

## Features

- Multi-AZ VPC
- Public Subnets
- Private Application Subnets
- Database Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Network ACLs
- Security Groups
- Amazon S3 Gateway Endpoint
- AWS Transit Gateway
- Enterprise Resource Tagging

---

## Architecture

```
                     Internet
                         |
                Internet Gateway
                         |
                  Public Subnets
                         |
                  NAT Gateway(s)
                         |
                Private Subnets
                         |
               Database Subnets
                         |
                Transit Gateway
```

---

## Module Structure

```
network/
├── versions.tf
├── providers.tf
├── variables.tf
├── locals.tf
├── vpc.tf
├── subnets.tf
├── internet-gateway.tf
├── nat-gateway.tf
├── route-tables.tf
├── security-groups.tf
├── network-acls.tf
├── endpoints.tf
├── transit-gateway.tf
├── outputs.tf
└── README.md
```

---

## Inputs

| Name | Description | Type |
|------|-------------|------|
| aws_region | AWS Region | string |
| project_name | Project name | string |
| environment | Deployment environment | string |
| vpc_cidr | VPC CIDR | string |
| availability_zones | Availability Zones | list(string) |
| public_subnet_cidrs | Public subnet CIDRs | list(string) |
| private_subnet_cidrs | Private subnet CIDRs | list(string) |
| database_subnet_cidrs | Database subnet CIDRs | list(string) |
| enable_nat_gateway | Deploy NAT Gateway | bool |
| enable_vpc_endpoints | Deploy VPC Endpoints | bool |
| tags | Resource Tags | map(string) |

---

## Outputs

- VPC ID
- Public Subnet IDs
- Private Subnet IDs
- Database Subnet IDs
- Transit Gateway ID

---

## Example Usage

```hcl
module "network" {

  source = "../../modules/network"

  aws_region = "us-east-1"

  project_name = "zero-trust"

  environment = "dev"

  vpc_cidr = "10.0.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]

  database_subnet_cidrs = [
    "10.0.21.0/24",
    "10.0.22.0/24"
  ]

  enable_nat_gateway = true

  enable_vpc_endpoints = true

  tags = {
    Project = "ZeroTrust"
  }

}
```

---

## Security Considerations

- Principle of Least Privilege
- Private application networking
- Segmented workloads
- Zero Trust architecture
- Enterprise tagging
- High Availability

---

## Future Enhancements

- VPC Flow Logs
- Interface Endpoints
- AWS Network Firewall
- IPv6
- Gateway Load Balancer
- Inspection VPC
- Multi-Region Networking
- Cloud WAN Integration

---

## License

MIT
