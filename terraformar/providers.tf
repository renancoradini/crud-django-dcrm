######
terraform {

  # backend "s3" {
  #   bucket = "ClientName-terraform-tfstate"
  #   key    = "main-ecs/terraform.tfstate"
  #   region = "us-east-2"
  # }

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.regionset
}
