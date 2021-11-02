terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  region = "sa-east-1"
  global_tags = {
    "environment" = "vpn-example"
  }
  availability_zones = sort(data.aws_availability_zones.available.names)
}

provider "aws" {
  region = local.region
}