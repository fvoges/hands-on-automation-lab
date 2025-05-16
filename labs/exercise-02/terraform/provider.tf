terraform {
  required_version = ">= 1.0, < 2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40, < 6.0" # Using a recent version
    }
  }
}

provider "aws" {
  region = var.aws_region
}
