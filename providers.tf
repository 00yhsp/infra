terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    # Backend configuration will be provided via -backend-config at init time
    # (Cloudflare R2 requires custom endpoint and s3_force_path_style)
  }
}

provider "aws" {
  region = var.aws_region
}

provider "tls" {}
