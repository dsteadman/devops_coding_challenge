# See https://www.terraform.io/docs/backends/types/remote.html
terraform {
  required_version = ">=1.5.0, <2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0"
    }
  }
}

