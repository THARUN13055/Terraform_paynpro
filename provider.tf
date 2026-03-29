terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.84.0"
    }
  }
}

provider "aws" {

  region = "ap-south-1"
}