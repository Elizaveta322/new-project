terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "new-project-tfstate-elizaveta"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
  }
}

provider "aws" {
  region = "us-east-1"
}
