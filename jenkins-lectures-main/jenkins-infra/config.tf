terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.59.0"
    }
  }
}
terraform {
  required_version = ">=0.12"
}

provider "aws" {
  region  = var.region
  profile = "default"
}