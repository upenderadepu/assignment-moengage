# AWS VPC Creation with Terraform
This project will create a VCP with Internet Gateway, subnets 

An SSH key pair is dynamically generated as well, and the private key is copied over to the
bastion host.

The ec2 instance in the public subnet is assigned a security group with access from the 
the intenret via port 22, 80 and 443.

Both security groups are dynamically created in the network module.

## Current state

Modules:

- ssh-key: Generates an ssh key pair
- network: Sets up a VPC with IGWs, NAT GWs, subnets, SG to 22, 80, 443 in from anywhere
- ec2: Currently creates a ec2 instance in a subnet

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| namespace | The project namespace to use for unique resource naming | `string` | `"moengage-terraform"` | no |
| region | AWS region | `string` | `"ap-south-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| public\_connection\_string | Copy/Paste/Enter |

