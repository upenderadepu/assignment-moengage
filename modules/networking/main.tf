
// TODO break public and private into separate AZs
data "aws_availability_zones" "available" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name                             = "${var.namespace}-vpc"
  cidr                             = "10.0.0.0/16"
  azs                              = data.aws_availability_zones.available.names
  public_subnets                   = ["10.0.101.0/24", "10.0.102.0/24"]
  create_database_subnet_group     = true
  single_nat_gateway               = true
}

// SG to allow 22, 80 and 443 connections from anywhere
resource "aws_security_group" "allow_ssh_pub" {
  name        = "${var.namespace}-allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.namespace}-allow_ports"
  }
}
