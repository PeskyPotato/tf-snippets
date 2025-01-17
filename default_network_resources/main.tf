terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "eu-central-1"
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

data "aws_security_group" "default_security_group" {
  vpc_id = data.aws_vpc.default_vpc.id
  name   = "default"
}

data "aws_internet_gateway" "default_internet_gateway" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

output "default_vpc_id" {
  value = data.aws_vpc.default_vpc.id
}

output "default_subnet_ids" {
  value = data.aws_subnets.default_subnets.ids
}

output "default_security_group_id" {
  value = data.aws_security_group.default_security_group.id
}

output "default_internet_gatway_id" {
  value = data.aws_internet_gateway.default_internet_gateway.id
}