terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
}

provider "aws" {
  region = "east-us-1"
}

module "vpc" {
  source = "./vpc_module"
  cidr_range = "10.0.0.0/28"
  sub_range = "10.0.1.0/29"
}

module "eks" {
  source = "./eks_module"
  eks_name = demo
}
