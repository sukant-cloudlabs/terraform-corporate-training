terraform {
  cloud {
    organization = "sukant-terraformlabs"
    workspaces { name = "terraform-corporate-training" }
  }

  required_providers {
    aws    = { source = "hashicorp/aws" }
    random = { source = "hashicorp/random" }
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "demo" {
  bucket = "tfc-demo-${random_id.suffix.hex}"
  tags = {
    Project = "TFC Demo"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.demo.bucket
}
