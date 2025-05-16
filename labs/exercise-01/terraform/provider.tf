terraform {
  required_version = ">= 1.0, < 2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40, < 6.0" # Using a recent version
    }
  }
}

# We're using the instance identity profile for authentication
# and the default region for the provider.
provider "aws" {}
