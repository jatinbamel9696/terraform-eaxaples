terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "terraform-rinku9696"
    key = "terraform-backend/route53-r/backend.tfstate"
    encrypt = true
    region = "ap-south-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}